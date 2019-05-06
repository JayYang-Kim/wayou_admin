package com.sp.hotel;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("hotel.scheduleController")
public class ScheduleController {
	
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping(value= "/hotel/reserve/reserveSchedule", method=RequestMethod.GET)
	public String schedule(
			@RequestParam(name="year", defaultValue="0") int year,
			@RequestParam(name="month", defaultValue="0") int month,
			Model model) {

		Calendar cal = Calendar.getInstance();
		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH)+1;
		int todayYear=y;
		int todayMonth = m;
		int todayDate = cal.get(Calendar.DATE);
		
		if(year==0)
			year=y;
		if(month==0)
			month=m;

		
		// year년 month월  1일의 요일 구하기
		cal.set(year, month-1, 1);
		year=cal.get(Calendar.YEAR);
		month=cal.get(Calendar.MONTH)+1;		
		int week=cal.get(Calendar.DAY_OF_WEEK); // 1~7
		
		String []w={"일","월","화","수","목","금","토"};


		String []days=new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
		String []weeks=new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
		
		for(int i=1; i<=days.length; i++) {
			if(week==1) {
				weeks[i-1]="<span style='color:red'>"+w[week-1]+"</span>";
				days[i-1]="<span style='color:red'>"+i+"일"+"</span>";
				week++;
				if(week>7) week=1;
			} else if(week==7) {
				weeks[i-1]="<span style='color:blue'>"+w[week-1]+"</span>";
				days[i-1]="<span style='color:blue'>"+i+"일"+"</span>";
				week++;
				if(week>7) week=1;
			} else {
				weeks[i-1]="<span>"+w[week-1]+"</span>";
				days[i-1]="<span>"+i+"일"+"</span>";
				week++;
				if(week>7) week=1;
			}
			
			
		}
		int hotelCode = 0;
		
		List<Schedule> listHotelName = hotelService.listHotelName();
		for(int i=0; i<=listHotelName.size(); i++) {
			hotelCode=listHotelName.get(i).getHotelCode();
		}
		
		List<Schedule> listRoomNum = hotelService.listRoomNum(hotelCode);
		
		model.addAttribute("listHotelName", listHotelName);
		model.addAttribute("listRoomNum", listRoomNum);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("todayDate", todayDate);
		model.addAttribute("todayMonth", todayMonth);
		model.addAttribute("todayYear", todayYear);
		model.addAttribute("weeks", weeks);
		model.addAttribute("days", days);
		return ".hotel.reserve.reserveSchedule";

	}

	
}

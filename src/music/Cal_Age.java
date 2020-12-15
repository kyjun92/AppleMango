package music;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Cal_Age {
	
	String date1;
	
	public Cal_Age(String date1) {
		this.date1 = date1;
	}

	public int sc_y() throws Exception {
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
	        Date FirstDate = format.parse(date1);
	        Date SecondDate = new Date();
	        float calDate = SecondDate.getTime() - FirstDate.getTime(); 
	        float calDateDays = calDate / ( 24*60*60*1000); 
	        calDateDays = Math.abs(calDateDays);
	        float day_year = (calDateDays / 365);
		 return (int)Math.ceil(day_year);
		 
	 }

}

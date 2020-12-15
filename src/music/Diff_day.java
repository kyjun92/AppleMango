package music;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Diff_day {
	
	    String date1;
	    String date2 = "2016-06-06";
	    
	    public float Diff_day(String date1) throws Exception{
	    	
	    	this.date1 = date1;
	    	SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
	        Date FirstDate = format.parse(date1);
	        Date SecondDate = format.parse(date2);
	        float calDate = FirstDate.getTime() - SecondDate.getTime(); 
	        float calDateDays = calDate / ( 24*60*60*1000); 
	        calDateDays = Math.abs(calDateDays);
	        float day_score = (calDateDays / 500);
	        float score_y = (float) (Math.abs(Math.log(day_score))+1)*10;
		 return score_y;
	 }
	    
	   
}

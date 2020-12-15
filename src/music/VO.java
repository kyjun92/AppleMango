package music;
import java.sql.Date;
public class VO {
	int id;
	String title;
	Date date;
	String artist;
	String lyric;
	String file;
	String img;
	String genre;
	int num_play;
	int playtime;
	
	int list_num;
	String music_id;
	
	public int getList_num() {
		return list_num;
	}
	public void setList_num(int list_num) {
		this.list_num = list_num;
	}
	public String getMusic_id() {
		return music_id;
	}
	public void setMusic_id(String music_id) {
		this.music_id = music_id;
	}
	public int getPlaytime() {
		return playtime;
	}
	public void setPlaytime(int playtime) {
		this.playtime = playtime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getArtist() {
		return artist;
	}
	public void setArtist(String artist) {
		this.artist = artist;
	}
	public String getLyric() {
		return lyric;
	}
	public void setLyric(String lyric) {
		this.lyric = lyric;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public int getNum_play() {
		return num_play;
	}
	public void setNum_play(int num_play) {
		this.num_play = num_play;
	}
}

package api;

public class test {

	public static void main(String[] args) {
		String path = "https://www.youtube.com/watch?v=0pBQMlgJpSk";
		String videoId = null;
		YoutubeAPI youtube = new YoutubeAPI(path);
		videoId = youtube.getVideoId();
		String jsonData = youtube.getData(videoId);
		String time = youtube.getDuration(jsonData);
		String duration = youtube.formatDuration(time);
		System.out.println(duration);
	}

}

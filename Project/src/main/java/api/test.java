package api;

public class test {

	public static void main(String[] args) {
		String path = "https://www.youtube.com/watch?v=0pBQMlgJpSk";
		String videoId = null;
		YoutubeAPI youtube = new YoutubeAPI(path);
		videoId = youtube.getVideoId();
		String jsonData = youtube.getData(videoId);
		String unformattedDuration = youtube.getDuration(jsonData);
		String duration = youtube.formatDuration(unformattedDuration);
		System.out.println(duration);
	}

}

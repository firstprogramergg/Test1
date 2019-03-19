import java.io.File;

//File 클래스
//파일(a.txt)>>생성, 수정, 삭제
//디렉토리(폴더)(C:\\Temp): 생성, 삭제

//사용: 파일정보, 폴더 정보

//C#: File 클래스, Directory 클래스 !!


//포인트: FileOutputStream, FileWriter(파일 생성 기능)
public class Ex07_File_Directory {

	public static void main(String[] args) {
		String path="C:\\Temp\\file.txt"; //file.txt 만들어져 있다는..
		File f=new File(path); //야 너 내가 file.txt 줄테니까 분석좀 해봐 //생성자만들어서 파일정보 보기
		
		String filename=f.getName();		
		System.out.println("파일명:"+filename);
		System.out.println("전체경로:"+f.getPath());
		System.out.println("너 폴더니:"+f.isDirectory()); //묻는 것 is
		System.out.println("절대경로:"+f.getAbsolutePath()); //Absolute
		System.out.println("너 파일이니:"+f.isFile());
		System.out.println("파일크기:"+f.length());
		System.out.println("부모경로:"+f.getParentFile()); //
		System.out.println("파일명:"+filename);
		System.out.println("파일존재 여부:"+f.exists());
		
		//f.creatNewFele() 파일생성
		//f.delete() 파일삭제 (return true, false)
		f.canWrite(); //can 쓸수 있니?
		
		
		
		
		
		
	}

}

import java.io.File;

//File Ŭ����
//����(a.txt)>>����, ����, ����
//���丮(����)(C:\\Temp): ����, ����

//���: ��������, ���� ����

//C#: File Ŭ����, Directory Ŭ���� !!


//����Ʈ: FileOutputStream, FileWriter(���� ���� ���)
public class Ex07_File_Directory {

	public static void main(String[] args) {
		String path="C:\\Temp\\file.txt"; //file.txt ������� �ִٴ�..
		File f=new File(path); //�� �� ���� file.txt ���״ϱ� �м��� �غ� //�����ڸ��� �������� ����
		
		String filename=f.getName();		
		System.out.println("���ϸ�:"+filename);
		System.out.println("��ü���:"+f.getPath());
		System.out.println("�� ������:"+f.isDirectory()); //���� �� is
		System.out.println("������:"+f.getAbsolutePath()); //Absolute
		System.out.println("�� �����̴�:"+f.isFile());
		System.out.println("����ũ��:"+f.length());
		System.out.println("�θ���:"+f.getParentFile()); //
		System.out.println("���ϸ�:"+filename);
		System.out.println("�������� ����:"+f.exists());
		
		//f.creatNewFele() ���ϻ���
		//f.delete() ���ϻ��� (return true, false)
		f.canWrite(); //can ���� �ִ�?
		
		
		
		
		
		
	}

}

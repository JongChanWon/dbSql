package org.opentutorials.javatutorials.numberstring;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Scanner;



public class Board {
	ArrayList<HashMap<String, Object>> board = new ArrayList<>();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	Scanner s = new Scanner(System.in);

	public static void main(String[] args) {
		// 조회, 등록, 수정, 삭제가 가능한 게시판을 만들어주세요
		// 번호, 제목, 내용, 작성자, 작성일

		// 처음엔 목록이 출력되고
		// 1.조회 2.등록 3.프로그램 종료
		// 조회시: 1.수정 2.삭제 3.목록

		Board b = new Board();
		b.init();

	}
	public void init() {

		while (true) {
			System.out.println("게시판");
			System.out
					.println("=================================================");
			System.out.println("번호\t제목\t\t작성자\t\t작성일");
			System.out
					.println("-------------------------------------------------");
			boardList();
			System.out.println();
			System.out.println("=================================================");

			System.out.println("1.조회\n2.등록\n3.프로그램 종료");
			int input =Integer.parseInt(s.nextLine());
			switch (input) {
			case 1:
				search();
				break;
			case 2:
				reg();
				break;
			case 3:
				System.exit(3);
				break;

			}

		}
	}
	void search() {
		

		System.out.println();
		System.out.println("1.수정\n2.삭제\n3.목록");
		int input = Integer.parseInt(s.nextLine());
		switch (input) {
		case 1:// 수정
			modify();
			break;
		case 2:// 삭제
			delete();
			break;
		case 3:// 목록
			boardList();
			break;
		default:
			break;
		}
		
	}
	//등록
	void reg() {
		HashMap<String, Object> hm = new HashMap<>();
		
		System.out.println("번호 >>");
		System.out.print("");
		int num = Integer.parseInt(s.nextLine());
		hm.put("no", num);

		System.out.println("제목 >>");
		String input2 = s.nextLine();
		hm.put("title", input2);

		System.out.println("작성자 >>");
		String input3 = s.nextLine();
		hm.put("user", input3);

		hm.put("date", new Date());
		board.add(hm);

	}

	void modify() {
		System.out.println();
		System.out.print("번호 >>");
		int input = Integer.parseInt(s.nextLine());
		for (int i = 0; i < board.size(); i++) {
			if(board.get(i).containsKey("no")) {
				if(board.get(i).get("no").equals(input)) {
					System.out.println("변경할 내용을 입력해 주세요.");
					String content = s.nextLine();
					System.out.println("유저변경");
					String user = s.nextLine();
//					board.get(i).put("no", h.get("no"));
					board.get(i).put("title", content);
					board.get(i).put("user",user);
//					board.get(i).put("date",h.get("date"));
					break;
				}
			}
			
		} 
		
	}

	void delete() {
		System.out.println();
		System.out.print("삭제할 번호를 입력해주세요");
		int num = s.nextInt();
		board.remove(num - 1);

	}

	void boardList() {
		for (HashMap<String, Object> hm : board) {
			System.out.printf("%-8d", hm.get("no"));
			System.out.printf("%-25s", hm.get("title"));
			System.out.printf("%-23s", hm.get("user"));
			System.out.printf(format.format(new Date()));
			System.out.println();
		}

	}

}

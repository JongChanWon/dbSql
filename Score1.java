package d_array;

import java.util.Arrays;

public class Score1 {

	public static void main(String[] args) {
		/*
		 * 우리반 모두의 Java, Oracle, HTML, CSS, JQuery, JSP 점수를 50~100 까지 랜덤으로 생성시키고
		 * 석차순으로 석차, 이름, 과목별 점수, 총점, 평균을 출력해주세요.
		 * 
		 * 석차	이름		Java	Oracle	HTML	CSS		JQuery  JSP		  총점	평균
		 * 1	홍길동	100		100		100		100		100		100		600		100.0
		 * 1	홍길동	100		100		100		100		100		100		600		100.0
		 * 1	홍길동	100		100		100		100		100		100		600		100.0
		 * 1	홍길동	100		100		100		100		100		100		600		100.0
		 * 1	홍길동	100		100		100		100		100		100		600		100.0
		 * 1	홍길동	100		100		100		100		100		100		600		100.0
		 * 1	홍길동	100		100		100		100		100		100		600		100.0
		 */
		System.out.println("석차        이름        Java     Oracle    HTML    CSS      JQuery    JSP    총점             평균");
		
		
		int[][] score = new int [24][6];
		int[] sum = new int [score.length];
		double[] avg = new double [score.length];
		String name = null;
		
		
		for(int i = 0; i < score.length; i++){
			for(int j = 0; j < score[i].length; j++){
				score[i][j] = (int)(Math.random()*100) + 1;
				
				
			}
			
			
			
			System.out.println(Arrays.toString(score[i]));
			
		}
		
		
		for(int i = 0; i < score.length; i++){
			for(int j = 0; j < score[i].length; j++){
				sum[i] += score[i][j];
				if(sum[i] > 0){
					
				}
			}
				avg[i] = (double)sum[i] / score[i].length;
		}
		System.out.println(Arrays.toString(sum) + Arrays.toString(avg));
		
		String [] students = {"라","미", "도"};
		String [] subjects = {"Java", "Oracle", "HTML", "CSS", "JQuery", "JSP"};
		double [][] scores = new double[students.length][subjects.length];
		
		
		//사용자가 직접 쓸수 있는 표 만들어오기 (이름 입력하면 석차 등수 나오게 하는거)
		
		
		
	}

}

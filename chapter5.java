package ttt;

import java.util.Arrays;

public class ArrTest {
	public static void main(String[] args) {
		/*
		 * 배열안에 9개의 숫자가 있다. 근데 그 숫자를 이용해서 
		 * 임의의 숫자 3개를 뽑아야 한다.
		 * 
		 */
		int[] ballArr = {1,2,3,4,5,6,7,8,9};
		int[] ball3 = new int[3]; //3개의 임의 숫자가 들어있다
		
		for(int i = 0; i < ballArr.length; i++) {
			//ballArr 안에 있는 숫자로  ball3 에 담아서 중복되지 않은 숫자 3개를 꺼낸다
			int j = (int)(Math.random()*ballArr.length); 
			//임의의 숫자를  j 라는 변수에 담는다
			int tmp = 0;
			tmp = ballArr[i];
			ballArr[i] = ballArr[j];
			ballArr[j] = tmp;
			System.out.print(ballArr[i] + ",");
		}
		System.out.println(Arrays.toString(ballArr));
		for(int i = 0; i < ball3.length; i++) {
			
			System.out.print(ballArr[i]);
//			System.out.print(ball3[i]);
		}
	}
}

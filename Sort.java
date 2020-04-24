package d_array;

import java.util.Arrays;

public class Sort {

	public static void main(String[] args) {
		/*
		 * 석차구하기: 모든 점수가 1등으로 시작해서 다른 점수들과 비교해 자신의 점수가 작으면 1씩증가시키는 방식 선택정렬: 첫번째
		 * 숫자부터 그 뒤의 모든숫자들과 비교해서 작은수와 자리바꾸기를 반복해 앞에서부터 작은수를 채워나가는 방식 버블정렬: 첫번째
		 * 숫자부터 바로 뒷 숫자와 비교해서 작은수와 자리 바꾸기를 반복해 뒤에서부터 큰수를 채워나가는 방식 삽입정렬: 두번째 숫자부터
		 * 그 앞의 모든 숫자들과 비교해서 큰수들을 뒤로 밀고 중간에 삽입하는 방식
		 */

		int[] numbers = new int[10];

		for (int i = 0; i < numbers.length; i++) {
			numbers[i] = (int) (Math.random() * 100) + 1;

		}
		System.out.println(Arrays.toString(numbers));
//		printRank(numbers); // 석차구하기
//		selectSort(numbers); // 선택정렬
//		bubbleSort(numbers); // 버블정렬
		insertSort(numbers); // 삽입정렬
	} // 메인메서드 끝나는 구간

	private static void insertSort(int[] numbers) {
		
		
		for(int i = 1; i < numbers.length; i++){
			int temp = numbers[i];
			int j = 0;
			for(j = i - 1; j >= 0; j--){
				if(temp < numbers[j]){
					numbers[j + 1] = numbers[j];	
				}else{
					break;
				}
			}
			numbers[j + 1] = temp;
		}	    	
		System.out.println(Arrays.toString(numbers));
	}

	private static void bubbleSort(int[] numbers) {
		
		
//		for(int i = 0; i < numbers.length; i++){
//			for(int j = 0; j < numbers.length; j++){
//				if(numbers[i] < numbers[j]){
//					int temp = numbers[i];
//					numbers[i] = numbers[j];
//					numbers[j] = temp;
//				}
//			}
//		}
//		System.out.println(Arrays.toString(numbers));
		
		for(int i = 0; i < numbers.length - 1; i++){
			boolean changed = false;
			for(int j = 0; j < numbers.length -1 - i; j++){
				if(numbers[j] > numbers[j + 1]){
				int temp = numbers[j];
				numbers[j] = numbers[j + 1];
				numbers[j + 1] = temp;
				changed = true;
				}
			}
			if(!changed){
				break;
			}
		}
		System.out.println(Arrays.toString(numbers));
	}
	
	private static void selectsort(int[] numbers) {

		for (int i = 0; i < numbers.length - 1; i++) {
			for (int j = i + 1; j < numbers.length; j++) {

				if (numbers[i] > numbers[j]) {
					int temp = numbers[i];
					numbers[i] = numbers[j];
					numbers[j] = temp;
				}
			}
		}
		System.out.println(Arrays.toString(numbers));

		// private static void printRank(int[] numbers) {
		//
		// int[] rank = new int [numbers.length];
		// for(int i = 0; i < numbers.length; i++){
		// for(int j = 0; j < numbers.length; j++){
		// rank[i] = 1;
		// if(numbers[i] < numbers[j]){
		// rank[i]++;
		// }
		// }
		// // }
		// System.out.println(Arrays.toString(rank));
		//
		//
		//
		// }
		//

	}

}

package music;

public class QuickSort {
	
	static void swap(int[][] a, int idx1, int idx2) {
		int[] t = {a[idx1][0],a[idx1][1]}; 
		a[idx1][0] = a[idx2][0];
		a[idx1][1] = a[idx2][1];
		a[idx2][0] = t[0];
		a[idx2][1] = t[1];
	}
	
	static void QuickSort(int[][] a, int l, int r) {
		int pl = l;
		int pr = r;
		int x = a[(pl + pr) / 2][0];
		
		do {
			while(a[pl][0] < x) pl++;
			while(a[pr][0] > x) pr--;
			if(pl <= pr) swap(a, pl++, pr--);
		}while(pl <= pr);
		
		if(l < pr) QuickSort(a, l, pr);
		if(pl < r) QuickSort(a, pl, r);
	}
	
	
//	public static void main(String[] args) {
//		int a[][] = {{9,8},{6,7},{1,2},{3,4},{5,1},{2,3}};
//		QuickSort(a, 0, 5);
//		for (int i = 0; i < a.length; i++) {
//			System.out.println("a[" + i + "][0] : " + a[i][0]+ " ::: " + "a[" + i + "][1] : " + a[i][1]);
//		}
//		
//	}

}

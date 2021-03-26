#!/bin/bash

#soal a
awk -F"\t" '
BEGIN {max_profit=0;}
{
	temp_profit = ($21/($18-$21))*100;
	if(max_profit == temp_profit){
		if(max_row_id < $1){
			max_row_id = $1;
			max_order_id = $2;
		}
	}
	if(max_profit < temp_profit){
		max_profit = temp_profit;
		max_row_id = $1;
		max_order_id = $2;
	}
}
END {printf("Transaksi terakhir dengan profit percentage terbesar yaitu %s dengan persentase %.2f%%.\n\n",max_order_id,max_profit);}
' Laporan-TokoShiSop.tsv > hasil.txt

#soal b
awk -F"\t" '
BEGIN {idx=0;}
/2017/ {
	if($10 == "Albuquerque" && !kembar[$7]){
		customer[idx] = $7;
		idx++;
		kembar[$7] = 1;
	}
}
END {
	printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n");
	for(i in customer) printf("%s\n",customer[i]);
	printf("\n");
}
' Laporan-TokoShiSop.tsv >> hasil.txt

#soal c
awk -F"\t" '
BEGIN {hom=0; con=0; cor=0;}
/Home Office/ {hom++}
/Consumer/ {con++}
/Corporate/ {cor++}
END {
	printf("Tipe segmen customer yang penjualannya paling sedikit adalah ");
	if(hom < con && hom < cor) printf("Home Office dengan %d transaksi.",hom);
	if(con < hom && con < cor) printf("Consumer dengan %d transaksi.",con);
	if(cor < hom && cor < con) printf("Corporate dengan %d transaksi.",cor);
	printf("\n\n");
}
' Laporan-TokoShiSop.tsv >> hasil.txt

#soal d
awk -F"\t" '
BEGIN {cen=0; eas=0; sou=0; wes=0}
/Central/ {cen+=$21}
/East/ {eas+=$21}
/South/ {sou+=$21}
/West/ {wes+=$21}
END {
	printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah ");
	if(cen<eas && cen<sou && cen<wes) printf("Central dengan total keuntungan %f",cen);
	if(eas<cen && eas<sou && eas<wes) printf("Central dengan total keuntungan %f",eas);
	if(sou<cen && sou<eas && sou<wes) printf("Central dengan total keuntungan %f",sou);
	if(wes<cen && wes<eas && wes<sou) printf("Central dengan total keuntungan %f",wes);
	printf("\n");
}
' Laporan-TokoShiSop.tsv >> hasil.txt

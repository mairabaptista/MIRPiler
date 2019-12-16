int findMin(int vetor[], int tam){
	int i;
	int pos;
	int min;
	i = 0;
	min = 99;

	while(i < tam) {
		if(min > vetor[i]) {
			min = vetor[i];
			pos = i;
		}
		i = i + 1;
	}
	
	output(pos);
	output(min);
}

void main(void){
	int vetor[5];
	int i;
	i = 0;

	while (i < 5){
		vetor[i] = input();
		i = i + 1;
	}

	findMin(vetor, 4);
}
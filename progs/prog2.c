int main(void) {
	int a;
    int b;
    int c;
    int d;
    int k;
	int out_var;

    a = input();
    d = 2;
    b = a * d;
    k = 3;
    c = a * k;
	
    out_var = (a + b + c) / d;
    output(out_var);
}
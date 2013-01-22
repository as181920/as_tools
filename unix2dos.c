#include <stdio.h>
#include <string.h>

void dis_fname(int,char* []);
void openf(int,char* []);
void conv(int,char* [],FILE*,FILE*);

int main(int argc,char *argv[]){

	dis_fname(argc,argv);

	openf(argc,argv);
}

void dis_fname(int argcd,char* argvd[]){
	int i;
	if(argcd==1)
		printf("NO FILE TO CONVERT!\n");
	else{
		printf("THESE FILES ARE GOING TO BE CONVERTED:\n");
		for(i=1;i<argcd;i++){
			printf("%s\t",argvd[i]);
		}
		printf("\n");
	}
}

void openf(int argco,char* argvo[]){
	int i;
	FILE* pf;
	FILE* pfo;
	char fileo[]=".ds";
	for(i=1;i<argco;i++){
		pf=fopen(argvo[i],"r");
		if(pfo==NULL){
			printf("OUTFILE OPEN ERROR!\n");
		}
		if(pf==NULL){
			printf("%s CAN NOT BE FOUND,NOT CONVERTED!\n",argvo[i]);
		}else{
			strcat(argvo[i],fileo);
			pfo=fopen(argvo[i],"w");
			conv(argco,argvo,pf,pfo);
			fclose(pfo);
		}
		fclose(pf);
	}
	printf("CONVERSION SUCCESSFULLY ENDED\n");
}

void conv(int argcc,char* argvc[],FILE* pfc,FILE* pfoc){
	char ch;
	while((ch=fgetc(pfc))!=EOF){
		if(ch=='\n')
			fputc('\r',pfoc);
		fputc(ch,pfoc);
	}
}

#include <stdio.h>
#include <stdlib.h>

void print_vetor(int* vetor, int tam);
void heapsort(int* vetor, int tam);
void constroi(int* vetor, int tam);
void refaz(int* vetor, int esq, int dir);

int main(){
    int vetor[] = {63, 9, 85, 66, 71};
    int tam = sizeof( vetor ) / sizeof( *vetor );

    print_vetor(vetor, tam);
    printf("\n");
    heapsort(vetor, tam);
    print_vetor(vetor, tam);

}

void print_vetor(int* vetor, int tam){
    int i = 0;
    for(i = 0; i < tam; i++){
        if(i < tam - 1)
            printf("%d - ", vetor[i]);
        else{
            printf("%d", vetor[i]);
        }
    }
    printf("\n");
}

void heapsort(int* vetor, int tam){
    int esq, dir;
    int aux;
    constroi(vetor, tam-1);
    esq = 0;
    dir = tam-1;
    while(dir > 0){
        aux = vetor[0];
        vetor[0] = vetor[dir];
        vetor[dir] = aux;
        dir--;
        refaz(vetor, esq, dir);
    }
}

void constroi(int* vetor, int tam){
    int esq;
    esq = tam / 2 + 1;
    while(esq > 0){
        esq--;
        refaz(vetor, esq, tam);
    }
}

void refaz(int* vetor, int esq, int dir){
    int i = esq;
    int j;
    int x;
    j = i * 2;
    x = vetor[i];
    while(j <= dir){
        if(j < dir){
            if(vetor[j] < vetor[j+1]){
                j++;
            }
        }
        if(x >= vetor[j]){
            break;
        }
        vetor[i] = vetor[j];
        i = j;
        j = i * 2;
    }
    vetor[i] = x;
}
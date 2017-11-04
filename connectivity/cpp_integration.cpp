/*Implemente um programa em C++ que, a partir de um menu simples, o usuário
escolha uma das ações abaixo:
● Encerrar: o programa deve permanecer em execução até que esta opção
seja selecionada.
● Inserção: O usuário pode realizar uma inserção sobre qualquer tabela do
banco.
● Atualização: O usuário pode realizar uma atualização de qualquer campo
permitido sobre qualquer tabela do banco.
● Remoção: O usuário pode realizar uma remoção de linha qualquer tabela do
banco.
○ Para inserção, atualização e remoção, a entrada deve ser colhida no
formato de um comando SQL correspondente, sem o ‘;’ final.

● Seleção: Permita ao usuário informar a condição de seleção para realizar
uma consulta sobre uma tabela pré determinada, retornando todos os
atributos da mesma.
○ A entrada deve ser colhida no formato de condição SQL (A parte da
consulta localizada depois da palavra reservada WHERE).
○ A saída deve conter:
● Nome das colunas retornadas;
● Informação de todas as linhas retornadas;
● Número de linhas retornadas da consulta.
Exemplo de saída:
"CEP			Descricao
51011000	Avenida Boa Viagem
51011001	Avenida Boa Viagem
Numero de linhas retornadas: 2
Process return 0 (0x0)
Press any key to continue."

Obs:​ ​A​ ​tabela​ ​escolhida​ ​pela​ ​equipe​ ​deve​ ​possuir,​ ​ao​ ​menos,​ ​quatro​ ​colunas.*/
#include "cstdio"
using namespace std;

void insert();
void update();
void remove();
void select();

int main ()
{
	int command;
	do 
	{
		printf("Choose an option:\n 0 - Exit\n 1 - Insert\n 2 - Update\n 3 - Remove\n 4 - Select\n");
		scanf("%d", &command);
		switch(command)
		{
			case 1:
					insert();
					break;
			case 2:
					update();
					break;
			case 3:
					remove();
					break;
			case 4:
					select();
					break;
			default:
					break;
		};
	} while(command != 0);
	return 0;
}

void insert()
{

}

void update()
{
	
}
void remove()
{

}

void select()
{

}
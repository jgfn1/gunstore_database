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
"department_code			namericao
51011000	Avenida Boa Viagem
51011001	Avenida Boa Viagem
Numero de linhas retornadas: 2
Process return 0 (0x0)
Press any key to continue."

Obs:​ ​A​ ​tabela​ ​escolhida​ ​pela​ ​equipe​ ​deve​ ​possuir,​ ​ao​ ​menos,​ ​quatro​ ​colunas.*/
// #include "cstdio"
#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <sql.h>
#include <sqlext.h>
#include <sqltypes.h>

using namespace std;

void insert();
void update();
void remove();
void select();
void execute_sql(SQLHDBC *dbc, char *command);

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
	SQLHENV env;
	SQLHDBC dbc;
	SQLHSTMT stmt;
	SQLRETURN ret;
	char  input_create[200];
	printf("Digite o comando SQL para remoção de uma tabela:\n");
	scanf("%s", input_create);
	/* Cria um manipulador de ambiente */
	SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
	/* Seta o ambiente para oferecer suporte a ODBC 3 */
	SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *)SQL_OV_ODBC3, 0);
	/* Cria um manipulador de conexão com a base de dados*/
	SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);
	/* Conecta ao DSN chamado "nome aqui"*/
	SQLDriverConnect(dbc, NULL, (SQLCHAR*)"DSN=Gunstore", SQL_NTS,NULL, 0, NULL, SQL_DRIVER_COMPLETE);
	execute_sql(&dbc, input_create);
}

void update()
{
	SQLHENV env;
	SQLHDBC dbc;
	SQLHSTMT stmt;
	SQLRETURN ret;
	char  input_update[200];
	printf("Digite o comando SQL para remoção de uma tabela:\n");
	scanf("%s", input_update);
	/* Cria um manipulador de ambiente */
	SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
	/* Seta o ambiente para oferecer suporte a ODBC 3 */
	SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *)SQL_OV_ODBC3, 0);
	/* Cria um manipulador de conexão com a base de dados*/
	SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);
	/* Conecta ao DSN chamado "nome aqui"*/
	SQLDriverConnect(dbc, NULL, (SQLCHAR*)"DSN=Gunstore", SQL_NTS,NULL, 0, NULL, SQL_DRIVER_COMPLETE);
	execute_sql(&dbc, input_update);
}

void remove()
{
	SQLHENV env;
	SQLHDBC dbc;
	SQLHSTMT stmt;
	SQLRETURN ret;
	char  input_remove[200];
	printf("Digite o comando SQL para remoção de uma tabela:\n");
	scanf("%s", input_remove);
	/* Cria um manipulador de ambiente */
	SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
	/* Seta o ambiente para oferecer suporte a ODBC 3 */
	SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *)SQL_OV_ODBC3, 0);
	/* Cria um manipulador de conexão com a base de dados*/
	SQLAllocHandle(SQL_HANDLE_DBC, env, &dbc);
	/* Conecta ao DSN chamado "nome aqui"*/
	SQLDriverConnect(dbc, NULL, (SQLCHAR*)"DSN=Gunstore", SQL_NTS,NULL, 0, NULL, SQL_DRIVER_COMPLETE);
	execute_sql(&dbc, input_remove);

}

void execute_sql(SQLHDBC *dbc, char *command)
{
    SQLHSTMT stmt;
    SQLRETURN ret;
    SQLAllocHandle(SQL_HANDLE_STMT, (*dbc), &stmt);
    ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS); //executa o comando de remoção
}

void select()
{
	int count = 0;
	char input[200];
	char teste;
	SQLHENV env;
    SQLHDBC dbc;
	SQLHSTMT stmt;
	SQLRETURN ret; // variável de status do retorno
	SQLLEN indicator[4]; // indica qual campo será acessado
	SQLLEN department_code; // variável que armazena o campo department_code
	SQLCHAR name[20]=""; // variável que armazena o campo name
	SQLLEN phone_extension;
	SQLLEN manager_cpf;
	printf("SELECT * FROM departments WHERE ");
	fflush(stdin);
	gets(input);//department_code > 1, por exemplo
	printf("%s\n", input);
	char command[400] = "SELECT * FROM departments WHERE ";
	//realoc para permitir que guarde uma instrução SQL maior
	//command = (char*) realloc(command,400*sizeof(char));
	strcat(command,input);//concatena as strings
	//exemplo: "SELECT * FROM adress"
	SQLAllocHandle(SQL_HANDLE_STMT, dbc, &stmt);
	/* armazena em department_code o campo de índice 0 */
	ret = SQLBindCol(stmt,1,SQL_C_LONG,&department_code,0,&indicator[0]);
	/* armazena em name o campo de índice 1 */
	ret = SQLBindCol(stmt,2,SQL_C_CHAR,name,sizeof(name),&indicator[1]);
	/* execução do comando */
	ret = SQLBindCol(stmt,1,SQL_C_LONG,&phone_extension,0,&indicator[2]);
	/* armazena em phone_extension o campo de índice 2 */
	ret = SQLBindCol(stmt,1,SQL_C_LONG,&manager_cpf,0,&indicator[3]);
	/* armazena em manager_cpf o campo de índice 3 */
	ret = SQLExecDirect(stmt,(SQLCHAR *)command,SQL_NTS);
	/* imprime os dados obtidos – sequência de fetch */
	count = 0;
	while((ret = SQLFetch(stmt)) != SQL_NO_DATA){
		printf("Department_code: %d \tname: %s \t", department_code, name);
		printf("phone_extension: %d \tmanager_cpf: %d\n", phone_extension, manager_cpf);
		count++;
	}
	printf("Numero de linhas retornadas: %d\n", count);
}

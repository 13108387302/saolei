#define _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include<time.h>
#define line 25
#define row 25
#define minesymbol '*'
int board(char arr[line][row]);
void initboard(char arr[line][row]);
void produce(char arr[line][row]);
int game(char arr[line][row],char arr2[line][row]);
int winner(char arr[line][row]);
int zero(char arr[line][row], int x, int y);
void zerowin(char arr[line][row], int x, int y);
int copy(char arr[line][row], char arr2[line][row]);
#define _CRT_SECURE_NO_WARNINGS 1
#include "扫雷.h"

void initboard(char arr[line][row]) {
	int a = 0, b = 0;
	for (a = 0; a < line; a++) {
		for (b = 0; b < row; b++) {
			arr[a][b] = ' ';
		}
	}
}
int board(char arr[line][row])
{
	int b = 0, c = 0, d = 1, e = 1;
again:
	printf(" %2d ", line - 1 - d);
	d++;
	for (b = 0; b < row-2; b++)
	{
		printf(" %c ", arr[c+1][b+1]);
		if (b < row - 3)
			printf("|");
	}
	c++;
	if (c == line-2) {
		printf("\n  ");
		for (e = 1; e <= row-2; e++)
			printf("  %2d", e);
		printf("\n");
		return 0;
	}
	printf("\n    ");
	for (b = 0; b < row-2; b++)
	{
		printf("---");
		if (b < row - 3)
			printf("|");
	}
	printf("\n");
	goto again;
}

void produce(char arr[line][row]) {
	int a, b, c=0, minenum=0,d=0;
	char p;
	input:
	printf("请输入地雷个数(共有%d个位置)\n",(line-2)*(row-2));
	d=scanf("%d", &minenum);
	while ((p = getchar()) != '\n' && p != EOF);
	if (minenum < (line - 2) * (row - 2)&&d==1) {
		srand((unsigned int)time(NULL));
		while (c < minenum) {
			a = rand() % (row - 2) + 1;
			b = rand() % (line - 2) + 1;
			if (arr[a][b] == ' ')
			{
				arr[a][b] = minesymbol;
				c++;
			}
		}
	}
	else {
		printf("输入违规,请重新输入");
		goto input;
	}
}

int count(char arr[line][row], int x, int y) {
	int count_ = 0;
	//右下
	if (arr[x + 1][y + 1] == minesymbol)
		count_++;
	//左上
	if (arr[x - 1][y - 1] == minesymbol)
		count_++;
	//左下
	if (arr[x + 1][y - 1] == minesymbol)
		count_++;
	//右上
	if (arr[x - 1][y + 1] == minesymbol)
		count_++;
	//下
	if (arr[x + 1][y] == minesymbol)
		count_++;
	//上
	if (arr[x-1][y] == minesymbol)
		count_++;
	//右
	if (arr[x][y + 1] == minesymbol)
		count_++;
	//左
	if (arr[x][y - 1] == minesymbol)
		count_++;
	return count_;
}
int winner(char arr[line][row]) {
	int a = 1, b = 1;
	for (a = 1; a < line-1; a++) {
		for (b = 1; b < row-1; b++) {
			if (arr[a][b] == ' ') {
				return 0;
			}
		}
	}
	return 1;
}
// && count(arr, x + 1, y + 1) == 0
int zero(char arr[line][row], int x, int y) {
	if (count(arr, x-1, y) == 0&&arr[x - 1][y] !=minesymbol)
		arr[x-1][y] = 48;
	if (count(arr, x+1, y) == 0 && arr[x + 1][y] != minesymbol)
		arr[x+1][y] = 48;
	if (count(arr, x, y-1) == 0 && arr[x][y - 1] != minesymbol)
		arr[x][y-1] = 48;
	if (count(arr, x, y+1) == 0 && arr[x][y + 1] != minesymbol)
		arr[x][y+1] = 48;
	if (count(arr, x-1, y-1) == 0 && arr[x - 1][y - 1] != minesymbol)
		arr[x-1][y-1] = 48;
	if (count(arr, x-1, y+1) == 0 && arr[x - 1][y + 1] != minesymbol)
		arr[x-1][y+1] = 48;
	if (count(arr, x+1, y+1) == 0 && arr[x + 1][y + 1] != minesymbol)
		arr[x+1][y+1] = 48;
	if (count(arr, x+1, y-1) == 0 && arr[x + 1][y - 1] != minesymbol)
		arr[x+1][y-1] = 48;
	return 0;
}


void zerowin(char arr[line][row], int x, int y) {
	zero(arr, x - 1, y - 1);
	zero(arr, x + 1, y + 1);
	zero(arr, x - 1, y + 1);
	zero(arr, x + 1, y - 1);
	zero(arr, x, y - 1);
	zero(arr, x - 1, y);
	zero(arr, x, y + 1);
	zero(arr, x + 1, y);
}


int copy(char arr[line][row], char arr2[line][row]) {
	int a = 0, b = 0;
	for (a = 0; a < line; a++) {
		for (b = 0; b < row; b++) {
			if (arr[a][b] != minesymbol) {
				arr2[a][b] = arr[a][b];
			}
		}
	}
	return 0;
}
int game(char arr[line][row],char arr2[line][row]) {
	int x, y,z,m,n,o=10;
	char c,p;
	again:
	printf("\n请输入你想扫除的坐标      格式：x,y\n");
	m=scanf("%d%c%d", &x,&c,&y);
	while ((p = getchar()) != '\n' && p != EOF);
	if ((x > 0 && x < row - 1) && (y > 0 && y < line - 1) && c == ','&&m==3) {
		if (arr[line - 1 - y][x] == ' ') {
			system("cls");
			z = count(arr, line - 1 - y, x);
			arr[line - y - 1][x] = z + 48;
			zero(arr, line - 1 - y, x);
			copy(arr, arr2);
			board(arr2);
			if (winner(arr) == 1) {
				printf("恭喜你，排除了所有的地雷");
				return 1;
			}
			goto again;
		}
		else if (arr[line - 1 - y][x] == minesymbol) {
			system("cls");
			arr2[line - 1 - y][x] = minesymbol;
			board(arr2);
			printf("你个傻蛋踩雷了吧哈哈哈\n");
			if (!o) {
				printf("你已无回溯机会，游戏结束");
				return 0;
			}
		input1:
			printf("是否回到上一步(你还有%d次回溯机会）：1.是       0.否\n", o);
			scanf("%d", &n);
			while ((p = getchar()) != '\n' && p != EOF);
			if (n == 1) {
				arr2[line - 1 - y][x] = ' ';
				system("cls");
				board(arr2);
				o--;
				goto again;
			}
			else if (n == 0)
				return 0;
			else { printf("无此选项");
			goto input1;
			}
		}
		else if (arr[line - 1 - y][x] > 47 && arr[line - 1 - y][x] < 58) {
			printf("该位置已被排雷，请重新输入\n");
			goto again;
		}
		else goto again;
	}
	else {
		printf("输入不规范，请重新输入");
		goto again;
	}
}
#define _CRT_SECURE_NO_WARNINGS 1
#include "扫雷.h"
#include <string.h>
#include <stdlib.h>
int main()
{
	char a;
	int c;
	printf("                             扫雷\n                   1.开始游戏   0.退出游戏\n");
gameagain:
	scanf("%c", &a);
	while ((c = getchar()) != '\n' && c != EOF);
	if (a-48 == 1) {
		char arr[line][row] = { 0 };
		char arr2[line][row] = { 0 };

		//初始化格子
		initboard(arr);
		initboard(arr2);
		//创建格子
		board(arr);
		//生成地雷
		produce(arr);
		//玩家进行游戏
		//game(arr)
		game(arr,arr2);
	}
	else if (a-48 == 0)
		return 0;
	else {
		printf("无此选项，请重新选择\n");
		goto gameagain;
	}
	printf("                    是否继续游戏\n                1.继续游戏  0.退出游戏\n");
	goto gameagain;
	return 0;
}

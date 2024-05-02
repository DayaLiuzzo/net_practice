#include <stdio.h>
#include <stdlib.h>
#include "netpractice.h"

void decimal_to_binary(int n)
{
    int nb;

    if(n / 2 > 0)
    {
        nb = n / 2;
        decimal_to_binary(nb);
    }
        putchar((n % 2) + '0');
}
void free_tab(char **strs)
{
    int i = 0;
    if(strs)
    {
        while(strs[i])
        {
            free(strs[i]);
            i++;
        }
        free(strs);
        strs = NULL;
    }
}

int main(int ac, char **av)
{
    int j = 0;
    int i = 1;
    char **ip;

    if(ac <= 1)
        exit(1);
    while(av[i])
    {
        ip = ft_split(av[i], '.');
        while(ip[j])
        {
            decimal_to_binary(atoi(ip[j]));
            if(ip[j + 1])
                printf(".");
            j++;
        }
        printf("\n");
        free_tab(ip);
        i++;
        j = 0;
    }
}
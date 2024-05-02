# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dliuzzo <dliuzzo@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/07 15:41:57 by dliuzzo           #+#    #+#              #
#    Updated: 2024/04/24 16:59:15 by dliuzzo          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = netpractice

S = src/

I = inc/

L = libft/

O = obj/

D = dep/


CC = cc

CFLAGS = -Wall -Wextra -Werror -g3

ifeq ($(MAKECMDGOALS), debug)
CFLAGS += -g3
#CFLAGS += -fsanitize=address
endif

CFLAGS += -I $I

LDFLAGS = -L$L -lft

SRCS =	$Smain.c 
#		$(addprefix $S, examplefolder/)

RM	=	rm -rf

OBJS =	$(SRCS:$S%=$O%.o)

DEP =	$(SRCS:$S%=$D%.d)

all : lib $(NAME)

$O:
	mkdir -p $@

$(OBJS): | $O

$(OBJS): $O%.o: $S%
#	mkdir -p $@
	$(CC) $(CFLAGS) -c $< -o $@

$D:
	mkdir -p $@

$(DEP): | $D

$(DEP): $D%.d: $S%
#	mkdir -p $@
	$(CC) $(CFLAGS) -MM -MF $@ -MT "$O$*.o $@" $<

$(NAME) : $(OBJS) $(DEP)
	$(CC) $(CFLAGS) $(OBJS) -o $(NAME) $(LDFLAGS) -lreadline

lib:
	make -C $L
	
debug: all

cleanobjs:
	$(RM) $(OBJS) $(O)

lclean:
	make fclean -C libft/

cleandep: 
	$(RM) $(DEP) $(D)

clean: cleanobjs cleandep

fclean : clean lclean
	$(RM) $(NAME)
#	$(RM) $(NAME)_bonus

re: fclean all

.PHONY: all clean fclean lclean re debug lib
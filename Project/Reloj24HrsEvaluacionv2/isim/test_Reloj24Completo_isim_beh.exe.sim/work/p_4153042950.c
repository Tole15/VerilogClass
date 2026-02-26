/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
extern char *STD_STANDARD;



int work_p_4153042950_sub_11288491338936809439_2211171780(char *t1, int t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    int t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    unsigned char t17;
    char *t18;
    int t19;
    int t20;
    char *t21;

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 384);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    *((int *)t8) = 1;
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 4U;
    t11 = (t4 + 4U);
    *((int *)t11) = t2;

LAB2:    t12 = (t5 + 56U);
    t13 = *((char **)t12);
    t14 = *((int *)t13);
    t15 = xsi_vhdl_pow(2, t14);
    t16 = (t15 - 1);
    t17 = (t2 > t16);
    if (t17 != 0)
        goto LAB3;

LAB5:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t14 = *((int *)t7);
    t0 = t14;

LAB1:    return t0;
LAB3:    t12 = (t5 + 56U);
    t18 = *((char **)t12);
    t19 = *((int *)t18);
    t20 = (t19 + 1);
    t12 = (t5 + 56U);
    t21 = *((char **)t12);
    t12 = (t21 + 0);
    *((int *)t12) = t20;
    goto LAB2;

LAB4:;
LAB6:;
}


extern void work_p_4153042950_init()
{
	static char *se[] = {(void *)work_p_4153042950_sub_11288491338936809439_2211171780};
	xsi_register_didat("work_p_4153042950", "isim/test_Reloj24Completo_isim_beh.exe.sim/work/p_4153042950.didat");
	xsi_register_subprogram_executes(se);
}

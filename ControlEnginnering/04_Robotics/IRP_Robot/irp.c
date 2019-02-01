/*
 * irp.c
 *
 * Code generation for model "irp".
 *
 * Model version              : 1.68
 * Simulink Coder version : 8.8 (R2015a) 09-Feb-2015
 * C source code generated on : Tue Apr 10 15:31:20 2018
 *
 * Target selection: rti1005.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->Custom
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "irp_trc_ptr.h"
#include "irp.h"
#include "irp_private.h"

/* Block signals (auto storage) */
B_irp_T irp_B;

/* Continuous states */
X_irp_T irp_X;

/* Block states (auto storage) */
DW_irp_T irp_DW;

/* Real-time model */
RT_MODEL_irp_T irp_M_;
RT_MODEL_irp_T *const irp_M = &irp_M_;

/*
 * This function updates continuous states using the ODE1 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE1_IntgData *id = (ODE1_IntgData *)rtsiGetSolverData(si);
  real_T *f0 = id->f[0];
  int_T i;
  int_T nXc = 10;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);
  rtsiSetdX(si, f0);
  irp_derivatives();
  rtsiSetT(si, tnew);
  for (i = 0; i < nXc; i++) {
    *x += h * f0[i];
    x++;
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

real_T rt_atan2d_snf(real_T u0, real_T u1)
{
  real_T y;
  int32_T tmp;
  int32_T tmp_0;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else if (rtIsInf(u0) && rtIsInf(u1)) {
    if (u1 > 0.0) {
      tmp = 1;
    } else {
      tmp = -1;
    }

    if (u0 > 0.0) {
      tmp_0 = 1;
    } else {
      tmp_0 = -1;
    }

    y = atan2(tmp_0, tmp);
  } else if (u1 == 0.0) {
    if (u0 > 0.0) {
      y = RT_PI / 2.0;
    } else if (u0 < 0.0) {
      y = -(RT_PI / 2.0);
    } else {
      y = 0.0;
    }
  } else {
    y = atan2(u0, u1);
  }

  return y;
}

/* Model output function */
void irp_output(void)
{
  int32_T rowIdx;
  real_T *lastU;
  real_T tmp;
  real_T u1;
  real_T u2;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* set solver stop time */
    if (!(irp_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&irp_M->solverInfo, ((irp_M->Timing.clockTickH0 + 1)
        * irp_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&irp_M->solverInfo, ((irp_M->Timing.clockTick0 + 1) *
        irp_M->Timing.stepSize0 + irp_M->Timing.clockTickH0 *
        irp_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(irp_M)) {
    irp_M->Timing.t[0] = rtsiGetT(&irp_M->solverInfo);
  }

  /* DataStoreRead: '<Root>/Start_bazowania_IN1' */
  irp_B.Start_bazowania_IN1 = irp_DW.Start_bazowania_IN;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* S-Function (rti_commonblock): '<S3>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* Memory: '<S43>/Memory' */
    irp_B.Memory = irp_DW.Memory_PreviousInput;
  }

  /* CombinatorialLogic: '<S43>/Logic' */
  tmp = irp_B.Start_bazowania_IN1;
  rowIdx = (tmp != 0.0);
  tmp = irp_B.SFunction1[0];
  rowIdx = (int32_T)(((uint32_T)rowIdx << 1) + (tmp != 0.0));
  tmp = irp_B.Memory;
  rowIdx = (int32_T)(((uint32_T)rowIdx << 1) + (tmp != 0.0));
  irp_B.Logic[0U] = irp_P.Logic_table[(uint32_T)rowIdx];
  irp_B.Logic[1U] = irp_P.Logic_table[rowIdx + 8U];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S21>/Memory' */
    irp_B.Memory_k = irp_DW.Memory_PreviousInput_o;
  }

  /* ZeroPole: '<S22>/Analog Butterworth LP Filter' */
  irp_B.AnalogButterworthLPFilter = 0.0;
  irp_B.AnalogButterworthLPFilter += irp_P.AnalogButterworthLPFilter_C *
    irp_X.AnalogButterworthLPFilter_CSTAT;

  /* ZeroPole: '<S23>/Analog Butterworth LP Filter1' */
  irp_B.AnalogButterworthLPFilter1 = 0.0;
  irp_B.AnalogButterworthLPFilter1 += irp_P.AnalogButterworthLPFilter1_C *
    irp_X.AnalogButterworthLPFilter1_CSTA;

  /* Fcn: '<S21>/Atan2' */
  irp_B.Atan2 = rt_atan2d_snf(irp_B.AnalogButterworthLPFilter,
    irp_B.AnalogButterworthLPFilter1);

  /* Derivative: '<S21>/Derivative' */
  if ((irp_DW.TimeStampA >= irp_M->Timing.t[0]) && (irp_DW.TimeStampB >=
       irp_M->Timing.t[0])) {
    irp_B.Derivative = 0.0;
  } else {
    tmp = irp_DW.TimeStampA;
    lastU = &irp_DW.LastUAtTimeA;
    if (irp_DW.TimeStampA < irp_DW.TimeStampB) {
      if (irp_DW.TimeStampB < irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB;
        lastU = &irp_DW.LastUAtTimeB;
      }
    } else {
      if (irp_DW.TimeStampA >= irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB;
        lastU = &irp_DW.LastUAtTimeB;
      }
    }

    tmp = irp_M->Timing.t[0] - tmp;
    irp_B.Derivative = (irp_B.Atan2 - *lastU) / tmp;
  }

  /* End of Derivative: '<S21>/Derivative' */

  /* DeadZone: '<S21>/Dead Zone' */
  if (irp_B.Derivative > irp_P.DeadZone_End) {
    irp_B.DeadZone = irp_B.Derivative - irp_P.DeadZone_End;
  } else if (irp_B.Derivative >= irp_P.DeadZone_Start) {
    irp_B.DeadZone = 0.0;
  } else {
    irp_B.DeadZone = irp_B.Derivative - irp_P.DeadZone_Start;
  }

  /* End of DeadZone: '<S21>/Dead Zone' */

  /* Saturate: '<S21>/Saturation' */
  tmp = irp_B.DeadZone;
  u1 = irp_P.Saturation_LowerSat_kj;
  u2 = irp_P.Saturation_UpperSat_l;
  if (tmp > u2) {
    irp_B.Saturation = u2;
  } else if (tmp < u1) {
    irp_B.Saturation = u1;
  } else {
    irp_B.Saturation = tmp;
  }

  /* End of Saturate: '<S21>/Saturation' */

  /* Sum: '<S21>/Sum' */
  irp_B.Sum = irp_B.Memory_k - irp_B.Saturation;

  /* Product: '<S21>/Product' */
  irp_B.Product = irp_B.Sum * irp_B.Logic[1];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S21>/Memory1' */
    irp_B.Memory1 = irp_DW.Memory1_PreviousInput;
  }

  /* Switch: '<S21>/Init Angle' */
  if (irp_B.Logic[1] >= irp_P.InitAngle_Threshold) {
    irp_B.InitAngle = irp_B.Memory1;
  } else {
    irp_B.InitAngle = irp_B.Atan2;
  }

  /* End of Switch: '<S21>/Init Angle' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S4>/Memory' */
    irp_B.Memory_f = irp_DW.Memory_PreviousInput_l;
  }

  /* DataStoreRead: '<Root>/IN_Os_11' */
  irp_B.IN_Os_11 = irp_DW.IN_Os_1;

  /* Abs: '<S4>/Abs' */
  irp_B.Abs = fabs(irp_B.IN_Os_11);

  /* Switch: '<S4>/Switch' */
  if (irp_B.Abs > irp_P.Switch_Threshold_b) {
    irp_B.Switch = irp_B.Memory_f;
  } else {
    irp_B.Switch = irp_B.IN_Os_11;
  }

  /* End of Switch: '<S4>/Switch' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S17>/Memory' */
    irp_B.Memory_ko = irp_DW.Memory_PreviousInput_j;
  }

  /* DataStoreRead: '<Root>/PRED_11 ' */
  irp_B.PRED_11 = irp_DW.PRED_1;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S17>/Memory1' */
    irp_B.Memory1_j = irp_DW.Memory1_PreviousInput_e;
  }

  /* Switch: '<S17>/Switch4' */
  if (irp_B.PRED_11 > irp_P.Switch4_Threshold) {
    irp_B.Switch4 = irp_B.PRED_11;
  } else {
    irp_B.Switch4 = irp_B.Memory1_j;
  }

  /* End of Switch: '<S17>/Switch4' */

  /* Switch: '<S17>/Switch3' */
  if (irp_B.Switch4 >= irp_P.Switch3_Threshold) {
    irp_B.Switch3 = irp_B.Memory_ko;
  } else {
    irp_B.Switch3 = irp_B.Switch4;
  }

  /* End of Switch: '<S17>/Switch3' */

  /* Switch: '<S13>/Switch' incorporates:
   *  Constant: '<S13>/Constant'
   */
  if (irp_B.Logic[0] > irp_P.Switch_Threshold_a) {
    irp_B.Switch_b = irp_P.Constant_Value;
  } else {
    /* Gain: '<S13>/norm' */
    irp_B.norm = irp_P.norm_Gain * irp_B.Switch3;

    /* Switch: '<Root>/Switch' incorporates:
     *  Constant: '<Root>/Constant'
     */
    if (irp_B.Logic[1] > irp_P.Switch_Threshold) {
      irp_B.Switch_c = irp_B.Switch;
    } else {
      irp_B.Switch_c = irp_P.Constant_Value_a;
    }

    /* End of Switch: '<Root>/Switch' */

    /* Gain: '<S21>/Conversion Rotation to Angle' */
    irp_B.ConversionRotationtoAngle_gr = irp_P.ConversionRotationtoAngle_Gain *
      irp_B.Product;

    /* Sum: '<S21>/Sum1' */
    irp_B.Sum1_o = (irp_B.ConversionRotationtoAngle_gr + irp_B.Atan2) -
      irp_B.InitAngle;

    /* Gain: '<S21>/Gear' */
    irp_B.Gear_m = irp_P.Gear_Gain * irp_B.Sum1_o;

    /* Gain: '<S21>/Conversion Rad to Deg' */
    irp_B.ConversionRadtoDeg_h = irp_P.ConversionRadtoDeg_Gain * irp_B.Gear_m;

    /* Sum: '<S13>/Sum' */
    irp_B.Sum_pe = irp_B.Switch_c - irp_B.ConversionRadtoDeg_h;

    /* Gain: '<S13>/reg P' */
    irp_B.regP_g = irp_P.regP_Gain * irp_B.Sum_pe;

    /* Saturate: '<S13>/Saturation' */
    tmp = irp_B.regP_g;
    u1 = irp_P.Saturation_LowerSat;
    u2 = irp_P.Saturation_UpperSat;
    if (tmp > u2) {
      irp_B.Saturation_o = u2;
    } else if (tmp < u1) {
      irp_B.Saturation_o = u1;
    } else {
      irp_B.Saturation_o = tmp;
    }

    /* End of Saturate: '<S13>/Saturation' */

    /* Product: '<S13>/Product' */
    irp_B.Product_ay = irp_B.Saturation_o * irp_B.norm;
    irp_B.Switch_b = irp_B.Product_ay;
  }

  /* End of Switch: '<S13>/Switch' */

  /* RateLimiter: '<S13>/Rate Limiter' */
  if (irp_DW.LastMajorTime == (rtInf)) {
    irp_B.RateLimiter = irp_B.Switch_b;
  } else {
    tmp = irp_M->Timing.t[0] - irp_DW.LastMajorTime;
    u1 = tmp * irp_P.RateLimiter_RisingLim;
    u2 = irp_B.Switch_b - irp_DW.PrevY;
    if (u2 > u1) {
      irp_B.RateLimiter = irp_DW.PrevY + u1;
    } else {
      tmp *= irp_P.RateLimiter_FallingLim;
      if (u2 < tmp) {
        irp_B.RateLimiter = irp_DW.PrevY + tmp;
      } else {
        irp_B.RateLimiter = irp_B.Switch_b;
      }
    }
  }

  /* End of RateLimiter: '<S13>/Rate Limiter' */

  /* Gain: '<S13>/Gain' */
  irp_B.Gain = irp_P.Gain_Gain * irp_B.RateLimiter;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN1' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
    ds2201_dac_out(DS2201_1_BASE, 1, (dsfloat) irp_B.Gain);

    /* Memory: '<S44>/Memory' */
    irp_B.Memory_p = irp_DW.Memory_PreviousInput_m;
  }

  /* CombinatorialLogic: '<S44>/Logic' */
  tmp = irp_B.Start_bazowania_IN1;
  rowIdx = (tmp != 0.0);
  tmp = irp_B.SFunction1[1];
  rowIdx = (int32_T)(((uint32_T)rowIdx << 1) + (tmp != 0.0));
  tmp = irp_B.Memory_p;
  rowIdx = (int32_T)(((uint32_T)rowIdx << 1) + (tmp != 0.0));
  irp_B.Logic_b[0U] = irp_P.Logic_table_o[(uint32_T)rowIdx];
  irp_B.Logic_b[1U] = irp_P.Logic_table_o[rowIdx + 8U];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S25>/Memory' */
    irp_B.Memory_l = irp_DW.Memory_PreviousInput_i;
  }

  /* ZeroPole: '<S26>/Analog Butterworth LP Filter' */
  irp_B.AnalogButterworthLPFilter_h = 0.0;
  irp_B.AnalogButterworthLPFilter_h += irp_P.AnalogButterworthLPFilter_C_p *
    irp_X.AnalogButterworthLPFilter_CST_d;

  /* ZeroPole: '<S27>/Analog Butterworth LP Filter1' */
  irp_B.AnalogButterworthLPFilter1_m = 0.0;
  irp_B.AnalogButterworthLPFilter1_m += irp_P.AnalogButterworthLPFilter1_C_i *
    irp_X.AnalogButterworthLPFilter1_CS_n;

  /* Fcn: '<S25>/Atan2' */
  irp_B.Atan2_h = rt_atan2d_snf(irp_B.AnalogButterworthLPFilter_h,
    irp_B.AnalogButterworthLPFilter1_m);

  /* Derivative: '<S25>/Derivative' */
  if ((irp_DW.TimeStampA_c >= irp_M->Timing.t[0]) && (irp_DW.TimeStampB_j >=
       irp_M->Timing.t[0])) {
    irp_B.Derivative_l = 0.0;
  } else {
    tmp = irp_DW.TimeStampA_c;
    lastU = &irp_DW.LastUAtTimeA_o;
    if (irp_DW.TimeStampA_c < irp_DW.TimeStampB_j) {
      if (irp_DW.TimeStampB_j < irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_j;
        lastU = &irp_DW.LastUAtTimeB_h;
      }
    } else {
      if (irp_DW.TimeStampA_c >= irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_j;
        lastU = &irp_DW.LastUAtTimeB_h;
      }
    }

    tmp = irp_M->Timing.t[0] - tmp;
    irp_B.Derivative_l = (irp_B.Atan2_h - *lastU) / tmp;
  }

  /* End of Derivative: '<S25>/Derivative' */

  /* DeadZone: '<S25>/Dead Zone' */
  if (irp_B.Derivative_l > irp_P.DeadZone_End_e) {
    irp_B.DeadZone_d = irp_B.Derivative_l - irp_P.DeadZone_End_e;
  } else if (irp_B.Derivative_l >= irp_P.DeadZone_Start_j) {
    irp_B.DeadZone_d = 0.0;
  } else {
    irp_B.DeadZone_d = irp_B.Derivative_l - irp_P.DeadZone_Start_j;
  }

  /* End of DeadZone: '<S25>/Dead Zone' */

  /* Saturate: '<S25>/Saturation' */
  tmp = irp_B.DeadZone_d;
  u1 = irp_P.Saturation_LowerSat_i;
  u2 = irp_P.Saturation_UpperSat_lr;
  if (tmp > u2) {
    irp_B.Saturation_c = u2;
  } else if (tmp < u1) {
    irp_B.Saturation_c = u1;
  } else {
    irp_B.Saturation_c = tmp;
  }

  /* End of Saturate: '<S25>/Saturation' */

  /* Sum: '<S25>/Sum' */
  irp_B.Sum_p = irp_B.Memory_l - irp_B.Saturation_c;

  /* Product: '<S25>/Product' */
  irp_B.Product_a = irp_B.Sum_p * irp_B.Logic_b[1];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S25>/Memory1' */
    irp_B.Memory1_f = irp_DW.Memory1_PreviousInput_p;
  }

  /* Switch: '<S25>/Init Angle' */
  if (irp_B.Logic_b[1] >= irp_P.InitAngle_Threshold_o) {
    irp_B.InitAngle_o = irp_B.Memory1_f;
  } else {
    irp_B.InitAngle_o = irp_B.Atan2_h;
  }

  /* End of Switch: '<S25>/Init Angle' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S6>/Memory' */
    irp_B.Memory_j = irp_DW.Memory_PreviousInput_g;
  }

  /* DataStoreRead: '<Root>/IN_Os_21' */
  irp_B.IN_Os_21 = irp_DW.IN_Os_2;

  /* Abs: '<S6>/Abs' */
  irp_B.Abs_l = fabs(irp_B.IN_Os_21);

  /* Switch: '<S6>/Switch' */
  if (irp_B.Abs_l > irp_P.Switch_Threshold_h) {
    irp_B.Switch_g = irp_B.Memory_j;
  } else {
    irp_B.Switch_g = irp_B.IN_Os_21;
  }

  /* End of Switch: '<S6>/Switch' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S5>/Memory' */
    irp_B.Memory_m = irp_DW.Memory_PreviousInput_a;
  }

  /* DataStoreRead: '<Root>/IN_Os_31' */
  irp_B.IN_Os_31 = irp_DW.IN_Os_3;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S5>/Memory1' */
    irp_B.Memory1_p = irp_DW.Memory1_PreviousInput_d;
  }

  /* Switch: '<S5>/Switch1' */
  if (irp_B.IN_Os_31 > irp_P.Switch1_Threshold_p) {
    irp_B.Switch1 = irp_B.IN_Os_31;
  } else {
    irp_B.Switch1 = irp_B.Memory1_p;
  }

  /* End of Switch: '<S5>/Switch1' */

  /* Switch: '<S5>/Switch' */
  if (irp_B.Switch1 > irp_P.Switch_Threshold_n) {
    irp_B.Switch_i = irp_B.Memory_m;
  } else {
    irp_B.Switch_i = irp_B.Switch1;
  }

  /* End of Switch: '<S5>/Switch' */

  /* Sum: '<S16>/Sum3' */
  irp_B.Sum3 = irp_B.Switch_i - irp_B.Switch_g;

  /* Abs: '<S16>/Abs' */
  irp_B.Abs_o = fabs(irp_B.Sum3);

  /* Switch: '<S16>/Switch' incorporates:
   *  Constant: '<S16>/Constant'
   *  Constant: '<S16>/Constant1'
   */
  if (irp_B.Abs_o > irp_P.Switch_Threshold_m) {
    irp_B.Switch_e = irp_P.Constant1_Value;
  } else {
    irp_B.Switch_e = irp_P.Constant_Value_n;
  }

  /* End of Switch: '<S16>/Switch' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S16>/Memory1' */
    irp_B.Memory1_d = irp_DW.Memory1_PreviousInput_h;
  }

  /* Switch: '<S16>/Switch2' */
  if (irp_B.Switch_e > irp_P.Switch2_Threshold_i) {
    irp_B.Switch2 = irp_B.Switch_g;
  } else {
    irp_B.Switch2 = irp_B.Memory1_d;
  }

  /* End of Switch: '<S16>/Switch2' */

  /* Switch: '<S14>/Switch' incorporates:
   *  Constant: '<S14>/Constant'
   */
  if (irp_B.Logic_b[0] > irp_P.Switch_Threshold_nq) {
    irp_B.Switch_n = irp_P.Constant_Value_o;
  } else {
    /* Gain: '<S14>/reg P1' */
    irp_B.regP1_i = irp_P.regP1_Gain * irp_B.Switch3;

    /* Switch: '<Root>/Switch1' incorporates:
     *  Constant: '<Root>/Constant5'
     */
    if (irp_B.Logic_b[1] > irp_P.Switch1_Threshold) {
      irp_B.Switch1_n = irp_B.Switch2;
    } else {
      irp_B.Switch1_n = irp_P.Constant5_Value;
    }

    /* End of Switch: '<Root>/Switch1' */

    /* Gain: '<S25>/Conversion Rotation to Angle' */
    irp_B.ConversionRotationtoAngle_k = irp_P.ConversionRotationtoAngle_Gai_k *
      irp_B.Product_a;

    /* Sum: '<S25>/Sum1' */
    irp_B.Sum1_k = (irp_B.ConversionRotationtoAngle_k + irp_B.Atan2_h) -
      irp_B.InitAngle_o;

    /* Gain: '<S25>/Gear' */
    irp_B.Gear_l = irp_P.Gear_Gain_d * irp_B.Sum1_k;

    /* Gain: '<S25>/Conversion Rad to Deg' */
    irp_B.ConversionRadtoDeg_a = irp_P.ConversionRadtoDeg_Gain_k * irp_B.Gear_l;

    /* Sum: '<S14>/Sum' */
    irp_B.Sum_j = irp_B.Switch1_n - irp_B.ConversionRadtoDeg_a;

    /* Gain: '<S14>/reg P' */
    irp_B.regP_k = irp_P.regP_Gain_p * irp_B.Sum_j;

    /* Saturate: '<S14>/Saturation' */
    tmp = irp_B.regP_k;
    u1 = irp_P.Saturation_LowerSat_k;
    u2 = irp_P.Saturation_UpperSat_k;
    if (tmp > u2) {
      irp_B.Saturation_m = u2;
    } else if (tmp < u1) {
      irp_B.Saturation_m = u1;
    } else {
      irp_B.Saturation_m = tmp;
    }

    /* End of Saturate: '<S14>/Saturation' */

    /* Product: '<S14>/Product' */
    irp_B.Product_b = irp_B.Saturation_m * irp_B.regP1_i;
    irp_B.Switch_n = irp_B.Product_b;
  }

  /* End of Switch: '<S14>/Switch' */

  /* RateLimiter: '<S14>/Rate Limiter' */
  if (irp_DW.LastMajorTime_p == (rtInf)) {
    irp_B.RateLimiter_f = irp_B.Switch_n;
  } else {
    tmp = irp_M->Timing.t[0] - irp_DW.LastMajorTime_p;
    u1 = tmp * irp_P.RateLimiter_RisingLim_o;
    u2 = irp_B.Switch_n - irp_DW.PrevY_p;
    if (u2 > u1) {
      irp_B.RateLimiter_f = irp_DW.PrevY_p + u1;
    } else {
      tmp *= irp_P.RateLimiter_FallingLim_d;
      if (u2 < tmp) {
        irp_B.RateLimiter_f = irp_DW.PrevY_p + tmp;
      } else {
        irp_B.RateLimiter_f = irp_B.Switch_n;
      }
    }
  }

  /* End of RateLimiter: '<S14>/Rate Limiter' */

  /* Gain: '<S14>/Gain' */
  irp_B.Gain_a = irp_P.Gain_Gain_g * irp_B.RateLimiter_f;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN2' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
    ds2201_dac_out(DS2201_1_BASE, 2, (dsfloat) irp_B.Gain_a);

    /* Memory: '<S45>/Memory' */
    irp_B.Memory_ff = irp_DW.Memory_PreviousInput_md;
  }

  /* CombinatorialLogic: '<S45>/Logic' */
  tmp = irp_B.Start_bazowania_IN1;
  rowIdx = (tmp != 0.0);
  tmp = irp_B.SFunction1[2];
  rowIdx = (int32_T)(((uint32_T)rowIdx << 1) + (tmp != 0.0));
  tmp = irp_B.Memory_ff;
  rowIdx = (int32_T)(((uint32_T)rowIdx << 1) + (tmp != 0.0));
  irp_B.Logic_f[0U] = irp_P.Logic_table_d[(uint32_T)rowIdx];
  irp_B.Logic_f[1U] = irp_P.Logic_table_d[rowIdx + 8U];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S29>/Memory' */
    irp_B.Memory_pt = irp_DW.Memory_PreviousInput_e;
  }

  /* ZeroPole: '<S30>/Analog Butterworth LP Filter' */
  irp_B.AnalogButterworthLPFilter_p = 0.0;
  irp_B.AnalogButterworthLPFilter_p += irp_P.AnalogButterworthLPFilter_C_j *
    irp_X.AnalogButterworthLPFilter_CST_c;

  /* ZeroPole: '<S31>/Analog Butterworth LP Filter1' */
  irp_B.AnalogButterworthLPFilter1_g = 0.0;
  irp_B.AnalogButterworthLPFilter1_g += irp_P.AnalogButterworthLPFilter1_C_n *
    irp_X.AnalogButterworthLPFilter1_CS_e;

  /* Fcn: '<S29>/Atan2' */
  irp_B.Atan2_b = rt_atan2d_snf(irp_B.AnalogButterworthLPFilter_p,
    irp_B.AnalogButterworthLPFilter1_g);

  /* Derivative: '<S29>/Derivative' */
  if ((irp_DW.TimeStampA_l >= irp_M->Timing.t[0]) && (irp_DW.TimeStampB_l >=
       irp_M->Timing.t[0])) {
    irp_B.Derivative_f = 0.0;
  } else {
    tmp = irp_DW.TimeStampA_l;
    lastU = &irp_DW.LastUAtTimeA_n;
    if (irp_DW.TimeStampA_l < irp_DW.TimeStampB_l) {
      if (irp_DW.TimeStampB_l < irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_l;
        lastU = &irp_DW.LastUAtTimeB_c;
      }
    } else {
      if (irp_DW.TimeStampA_l >= irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_l;
        lastU = &irp_DW.LastUAtTimeB_c;
      }
    }

    tmp = irp_M->Timing.t[0] - tmp;
    irp_B.Derivative_f = (irp_B.Atan2_b - *lastU) / tmp;
  }

  /* End of Derivative: '<S29>/Derivative' */

  /* DeadZone: '<S29>/Dead Zone' */
  if (irp_B.Derivative_f > irp_P.DeadZone_End_l) {
    irp_B.DeadZone_l = irp_B.Derivative_f - irp_P.DeadZone_End_l;
  } else if (irp_B.Derivative_f >= irp_P.DeadZone_Start_e) {
    irp_B.DeadZone_l = 0.0;
  } else {
    irp_B.DeadZone_l = irp_B.Derivative_f - irp_P.DeadZone_Start_e;
  }

  /* End of DeadZone: '<S29>/Dead Zone' */

  /* Saturate: '<S29>/Saturation' */
  tmp = irp_B.DeadZone_l;
  u1 = irp_P.Saturation_LowerSat_e;
  u2 = irp_P.Saturation_UpperSat_p;
  if (tmp > u2) {
    irp_B.Saturation_e = u2;
  } else if (tmp < u1) {
    irp_B.Saturation_e = u1;
  } else {
    irp_B.Saturation_e = tmp;
  }

  /* End of Saturate: '<S29>/Saturation' */

  /* Sum: '<S29>/Sum' */
  irp_B.Sum_f = irp_B.Memory_pt - irp_B.Saturation_e;

  /* Product: '<S29>/Product' */
  irp_B.Product_c = irp_B.Sum_f * irp_B.Logic_f[1];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S29>/Memory1' */
    irp_B.Memory1_o = irp_DW.Memory1_PreviousInput_c;
  }

  /* Switch: '<S29>/Init Angle' */
  if (irp_B.Logic_f[1] >= irp_P.InitAngle_Threshold_e) {
    irp_B.InitAngle_k = irp_B.Memory1_o;
  } else {
    irp_B.InitAngle_k = irp_B.Atan2_b;
  }

  /* End of Switch: '<S29>/Init Angle' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S16>/Memory' */
    irp_B.Memory_a = irp_DW.Memory_PreviousInput_ah;
  }

  /* Switch: '<S16>/Switch1' */
  if (irp_B.Switch_e > irp_P.Switch1_Threshold_k) {
    irp_B.Switch1_a = irp_B.Switch_i;
  } else {
    irp_B.Switch1_a = irp_B.Memory_a;
  }

  /* End of Switch: '<S16>/Switch1' */

  /* Switch: '<S15>/Switch' incorporates:
   *  Constant: '<S15>/Constant'
   */
  if (irp_B.Logic_f[0] > irp_P.Switch_Threshold_be) {
    irp_B.Switch_f = irp_P.Constant_Value_g;
  } else {
    /* Gain: '<S15>/reg P1' */
    irp_B.regP1 = irp_P.regP1_Gain_l * irp_B.Switch3;

    /* Switch: '<Root>/Switch2' incorporates:
     *  Constant: '<Root>/Constant6'
     */
    if (irp_B.Logic_f[1] > irp_P.Switch2_Threshold) {
      irp_B.Switch2_h = irp_B.Switch1_a;
    } else {
      irp_B.Switch2_h = irp_P.Constant6_Value;
    }

    /* End of Switch: '<Root>/Switch2' */

    /* Gain: '<S29>/Conversion Rotation to Angle' */
    irp_B.ConversionRotationtoAngle_go = irp_P.ConversionRotationtoAngle_Gai_n *
      irp_B.Product_c;

    /* Sum: '<S29>/Sum1' */
    irp_B.Sum1_d = (irp_B.ConversionRotationtoAngle_go + irp_B.Atan2_b) -
      irp_B.InitAngle_k;

    /* Gain: '<S29>/Gear' */
    irp_B.Gear_a = irp_P.Gear_Gain_c * irp_B.Sum1_d;

    /* Gain: '<S29>/Conversion Rad to Deg' */
    irp_B.ConversionRadtoDeg_n = irp_P.ConversionRadtoDeg_Gain_i * irp_B.Gear_a;

    /* Sum: '<S15>/Sum' */
    irp_B.Sum_p3 = irp_B.Switch2_h - irp_B.ConversionRadtoDeg_n;

    /* Gain: '<S15>/reg P' */
    irp_B.regP = irp_P.regP_Gain_i * irp_B.Sum_p3;

    /* Saturate: '<S15>/Saturation' */
    tmp = irp_B.regP;
    u1 = irp_P.Saturation_LowerSat_kh;
    u2 = irp_P.Saturation_UpperSat_c;
    if (tmp > u2) {
      irp_B.Saturation_d = u2;
    } else if (tmp < u1) {
      irp_B.Saturation_d = u1;
    } else {
      irp_B.Saturation_d = tmp;
    }

    /* End of Saturate: '<S15>/Saturation' */

    /* Product: '<S15>/Product' */
    irp_B.Product_k0 = irp_B.Saturation_d * irp_B.regP1;
    irp_B.Switch_f = irp_B.Product_k0;
  }

  /* End of Switch: '<S15>/Switch' */

  /* RateLimiter: '<S15>/Rate Limiter' */
  if (irp_DW.LastMajorTime_l == (rtInf)) {
    irp_B.RateLimiter_c = irp_B.Switch_f;
  } else {
    tmp = irp_M->Timing.t[0] - irp_DW.LastMajorTime_l;
    u1 = tmp * irp_P.RateLimiter_RisingLim_e;
    u2 = irp_B.Switch_f - irp_DW.PrevY_m;
    if (u2 > u1) {
      irp_B.RateLimiter_c = irp_DW.PrevY_m + u1;
    } else {
      tmp *= irp_P.RateLimiter_FallingLim_a;
      if (u2 < tmp) {
        irp_B.RateLimiter_c = irp_DW.PrevY_m + tmp;
      } else {
        irp_B.RateLimiter_c = irp_B.Switch_f;
      }
    }
  }

  /* End of RateLimiter: '<S15>/Rate Limiter' */

  /* Gain: '<S15>/Gain' */
  irp_B.Gain_o = irp_P.Gain_Gain_i * irp_B.RateLimiter_c;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN3' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
    ds2201_dac_out(DS2201_1_BASE, 3, (dsfloat) irp_B.Gain_o);

    /* Memory: '<S33>/Memory' */
    irp_B.Memory_pp = irp_DW.Memory_PreviousInput_mg;
  }

  /* ZeroPole: '<S34>/Analog Butterworth LP Filter' */
  irp_B.AnalogButterworthLPFilter_e = 0.0;
  irp_B.AnalogButterworthLPFilter_e += irp_P.AnalogButterworthLPFilter_C_d *
    irp_X.AnalogButterworthLPFilter_CS_dc;

  /* ZeroPole: '<S35>/Analog Butterworth LP Filter1' */
  irp_B.AnalogButterworthLPFilter1_h = 0.0;
  irp_B.AnalogButterworthLPFilter1_h += irp_P.AnalogButterworthLPFilter1_C_l *
    irp_X.AnalogButterworthLPFilter1_CS_c;

  /* Fcn: '<S33>/Atan2' */
  irp_B.Atan2_o = rt_atan2d_snf(irp_B.AnalogButterworthLPFilter_e,
    irp_B.AnalogButterworthLPFilter1_h);

  /* Derivative: '<S33>/Derivative' */
  if ((irp_DW.TimeStampA_h >= irp_M->Timing.t[0]) && (irp_DW.TimeStampB_c >=
       irp_M->Timing.t[0])) {
    irp_B.Derivative_g = 0.0;
  } else {
    tmp = irp_DW.TimeStampA_h;
    lastU = &irp_DW.LastUAtTimeA_d;
    if (irp_DW.TimeStampA_h < irp_DW.TimeStampB_c) {
      if (irp_DW.TimeStampB_c < irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_c;
        lastU = &irp_DW.LastUAtTimeB_b;
      }
    } else {
      if (irp_DW.TimeStampA_h >= irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_c;
        lastU = &irp_DW.LastUAtTimeB_b;
      }
    }

    tmp = irp_M->Timing.t[0] - tmp;
    irp_B.Derivative_g = (irp_B.Atan2_o - *lastU) / tmp;
  }

  /* End of Derivative: '<S33>/Derivative' */

  /* DeadZone: '<S33>/Dead Zone' */
  if (irp_B.Derivative_g > irp_P.DeadZone_End_lz) {
    irp_B.DeadZone_h = irp_B.Derivative_g - irp_P.DeadZone_End_lz;
  } else if (irp_B.Derivative_g >= irp_P.DeadZone_Start_b) {
    irp_B.DeadZone_h = 0.0;
  } else {
    irp_B.DeadZone_h = irp_B.Derivative_g - irp_P.DeadZone_Start_b;
  }

  /* End of DeadZone: '<S33>/Dead Zone' */

  /* Saturate: '<S33>/Saturation' */
  tmp = irp_B.DeadZone_h;
  u1 = irp_P.Saturation_LowerSat_g;
  u2 = irp_P.Saturation_UpperSat_f;
  if (tmp > u2) {
    irp_B.Saturation_k = u2;
  } else if (tmp < u1) {
    irp_B.Saturation_k = u1;
  } else {
    irp_B.Saturation_k = tmp;
  }

  /* End of Saturate: '<S33>/Saturation' */

  /* Sum: '<S33>/Sum' */
  irp_B.Sum_b = irp_B.Memory_pp - irp_B.Saturation_k;

  /* Product: '<S33>/Product' incorporates:
   *  Constant: '<Root>/Constant3'
   */
  irp_B.Product_ag = irp_B.Sum_b * irp_P.Constant3_Value;

  /* Gain: '<S33>/Conversion Rotation to Angle' */
  irp_B.ConversionRotationtoAngle = irp_P.ConversionRotationtoAngle_Gai_b *
    irp_B.Product_ag;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S33>/Memory1' */
    irp_B.Memory1_a = irp_DW.Memory1_PreviousInput_n;
  }

  /* Switch: '<S33>/Init Angle' incorporates:
   *  Constant: '<Root>/Constant3'
   */
  if (irp_P.Constant3_Value >= irp_P.InitAngle_Threshold_a) {
    irp_B.InitAngle_m = irp_B.Memory1_a;
  } else {
    irp_B.InitAngle_m = irp_B.Atan2_o;
  }

  /* End of Switch: '<S33>/Init Angle' */

  /* Sum: '<S33>/Sum1' */
  irp_B.Sum1 = (irp_B.ConversionRotationtoAngle + irp_B.Atan2_o) -
    irp_B.InitAngle_m;

  /* Gain: '<S33>/Gear' */
  irp_B.Gear = irp_P.Gear_Gain_c2 * irp_B.Sum1;

  /* Gain: '<S33>/Conversion Rad to Deg' */
  irp_B.ConversionRadtoDeg = irp_P.ConversionRadtoDeg_Gain_k4 * irp_B.Gear;

  /* Sum: '<S18>/Sum3' incorporates:
   *  Constant: '<Root>/Constant1'
   */
  irp_B.Sum3_i = irp_P.Constant1_Value_i - irp_B.ConversionRadtoDeg;

  /* Gain: '<S18>/reg P4' */
  irp_B.regP4 = irp_P.regP4_Gain * irp_B.Sum3_i;

  /* Saturate: '<S18>/Saturation4' */
  tmp = irp_B.regP4;
  u1 = irp_P.Saturation4_LowerSat;
  u2 = irp_P.Saturation4_UpperSat;
  if (tmp > u2) {
    irp_B.Saturation4 = u2;
  } else if (tmp < u1) {
    irp_B.Saturation4 = u1;
  } else {
    irp_B.Saturation4 = tmp;
  }

  /* End of Saturate: '<S18>/Saturation4' */

  /* RateLimiter: '<S18>/Rate Limiter4' */
  if (irp_DW.LastMajorTime_k == (rtInf)) {
    irp_B.RateLimiter4 = irp_B.Saturation4;
  } else {
    tmp = irp_M->Timing.t[0] - irp_DW.LastMajorTime_k;
    u1 = tmp * irp_P.RateLimiter4_RisingLim;
    u2 = irp_B.Saturation4 - irp_DW.PrevY_b;
    if (u2 > u1) {
      irp_B.RateLimiter4 = irp_DW.PrevY_b + u1;
    } else {
      tmp *= irp_P.RateLimiter4_FallingLim;
      if (u2 < tmp) {
        irp_B.RateLimiter4 = irp_DW.PrevY_b + tmp;
      } else {
        irp_B.RateLimiter4 = irp_B.Saturation4;
      }
    }
  }

  /* End of RateLimiter: '<S18>/Rate Limiter4' */

  /* Gain: '<S18>/Gain4' */
  irp_B.Gain4 = irp_P.Gain4_Gain * irp_B.RateLimiter4;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN4' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
    ds2201_dac_out(DS2201_1_BASE, 4, (dsfloat) irp_B.Gain4);

    /* Memory: '<S37>/Memory' */
    irp_B.Memory_b = irp_DW.Memory_PreviousInput_o4;
  }

  /* ZeroPole: '<S38>/Analog Butterworth LP Filter' */
  irp_B.AnalogButterworthLPFilter_n = 0.0;
  irp_B.AnalogButterworthLPFilter_n += irp_P.AnalogButterworthLPFilter_C_o *
    irp_X.AnalogButterworthLPFilter_CST_j;

  /* ZeroPole: '<S39>/Analog Butterworth LP Filter1' */
  irp_B.AnalogButterworthLPFilter1_l = 0.0;
  irp_B.AnalogButterworthLPFilter1_l += irp_P.AnalogButterworthLPFilter1_C_o *
    irp_X.AnalogButterworthLPFilter1_CS_h;

  /* Fcn: '<S37>/Atan2' */
  irp_B.Atan2_c = rt_atan2d_snf(irp_B.AnalogButterworthLPFilter_n,
    irp_B.AnalogButterworthLPFilter1_l);

  /* Derivative: '<S37>/Derivative' */
  if ((irp_DW.TimeStampA_k >= irp_M->Timing.t[0]) && (irp_DW.TimeStampB_i >=
       irp_M->Timing.t[0])) {
    irp_B.Derivative_k = 0.0;
  } else {
    tmp = irp_DW.TimeStampA_k;
    lastU = &irp_DW.LastUAtTimeA_p;
    if (irp_DW.TimeStampA_k < irp_DW.TimeStampB_i) {
      if (irp_DW.TimeStampB_i < irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_i;
        lastU = &irp_DW.LastUAtTimeB_d;
      }
    } else {
      if (irp_DW.TimeStampA_k >= irp_M->Timing.t[0]) {
        tmp = irp_DW.TimeStampB_i;
        lastU = &irp_DW.LastUAtTimeB_d;
      }
    }

    tmp = irp_M->Timing.t[0] - tmp;
    irp_B.Derivative_k = (irp_B.Atan2_c - *lastU) / tmp;
  }

  /* End of Derivative: '<S37>/Derivative' */

  /* DeadZone: '<S37>/Dead Zone' */
  if (irp_B.Derivative_k > irp_P.DeadZone_End_b) {
    irp_B.DeadZone_p = irp_B.Derivative_k - irp_P.DeadZone_End_b;
  } else if (irp_B.Derivative_k >= irp_P.DeadZone_Start_c) {
    irp_B.DeadZone_p = 0.0;
  } else {
    irp_B.DeadZone_p = irp_B.Derivative_k - irp_P.DeadZone_Start_c;
  }

  /* End of DeadZone: '<S37>/Dead Zone' */

  /* Saturate: '<S37>/Saturation' */
  tmp = irp_B.DeadZone_p;
  u1 = irp_P.Saturation_LowerSat_gg;
  u2 = irp_P.Saturation_UpperSat_g;
  if (tmp > u2) {
    irp_B.Saturation_ej = u2;
  } else if (tmp < u1) {
    irp_B.Saturation_ej = u1;
  } else {
    irp_B.Saturation_ej = tmp;
  }

  /* End of Saturate: '<S37>/Saturation' */

  /* Sum: '<S37>/Sum' */
  irp_B.Sum_fc = irp_B.Memory_b - irp_B.Saturation_ej;

  /* Product: '<S37>/Product' incorporates:
   *  Constant: '<Root>/Constant2'
   */
  irp_B.Product_k = irp_B.Sum_fc * irp_P.Constant2_Value;

  /* Gain: '<S37>/Conversion Rotation to Angle' */
  irp_B.ConversionRotationtoAngle_g = irp_P.ConversionRotationtoAngle_Gai_g *
    irp_B.Product_k;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Memory: '<S37>/Memory1' */
    irp_B.Memory1_l = irp_DW.Memory1_PreviousInput_dv;
  }

  /* Switch: '<S37>/Init Angle' incorporates:
   *  Constant: '<Root>/Constant2'
   */
  if (irp_P.Constant2_Value >= irp_P.InitAngle_Threshold_i) {
    irp_B.InitAngle_l = irp_B.Memory1_l;
  } else {
    irp_B.InitAngle_l = irp_B.Atan2_c;
  }

  /* End of Switch: '<S37>/Init Angle' */

  /* Sum: '<S37>/Sum1' */
  irp_B.Sum1_p = (irp_B.ConversionRotationtoAngle_g + irp_B.Atan2_c) -
    irp_B.InitAngle_l;

  /* Gain: '<S37>/Gear' */
  irp_B.Gear_c = irp_P.Gear_Gain_h * irp_B.Sum1_p;

  /* Gain: '<S37>/Conversion Rad to Deg' */
  irp_B.ConversionRadtoDeg_j = irp_P.ConversionRadtoDeg_Gain_a * irp_B.Gear_c;

  /* Sum: '<S19>/Sum4' incorporates:
   *  Constant: '<Root>/Constant4'
   */
  irp_B.Sum4 = irp_P.Constant4_Value - irp_B.ConversionRadtoDeg_j;

  /* Gain: '<S19>/reg P3' */
  irp_B.regP3 = irp_P.regP3_Gain * irp_B.Sum4;

  /* Saturate: '<S19>/Saturation3' */
  tmp = irp_B.regP3;
  u1 = irp_P.Saturation3_LowerSat;
  u2 = irp_P.Saturation3_UpperSat;
  if (tmp > u2) {
    irp_B.Saturation3 = u2;
  } else if (tmp < u1) {
    irp_B.Saturation3 = u1;
  } else {
    irp_B.Saturation3 = tmp;
  }

  /* End of Saturate: '<S19>/Saturation3' */

  /* RateLimiter: '<S19>/Rate Limiter3' */
  if (irp_DW.LastMajorTime_g == (rtInf)) {
    irp_B.RateLimiter3 = irp_B.Saturation3;
  } else {
    tmp = irp_M->Timing.t[0] - irp_DW.LastMajorTime_g;
    u1 = tmp * irp_P.RateLimiter3_RisingLim;
    u2 = irp_B.Saturation3 - irp_DW.PrevY_l;
    if (u2 > u1) {
      irp_B.RateLimiter3 = irp_DW.PrevY_l + u1;
    } else {
      tmp *= irp_P.RateLimiter3_FallingLim;
      if (u2 < tmp) {
        irp_B.RateLimiter3 = irp_DW.PrevY_l + tmp;
      } else {
        irp_B.RateLimiter3 = irp_B.Saturation3;
      }
    }
  }

  /* End of RateLimiter: '<S19>/Rate Limiter3' */

  /* Gain: '<S19>/Gain3' */
  irp_B.Gain3 = irp_P.Gain3_Gain * irp_B.RateLimiter3;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN5' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP2 */
    ds2201_dac_out(DS2201_1_BASE, 5, (dsfloat) irp_B.Gain3);

    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN6' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN7' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN8' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S1>/S-Function1' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:ADC Group:GROUP1 */
    irp_B.SFunction1_h[0] = (real_T)ds2201_adc_in(DS2201_1_BASE, 1);
    irp_B.SFunction1_h[1] = (real_T)ds2201_adc_in(DS2201_1_BASE, 2);
    irp_B.SFunction1_h[2] = (real_T)ds2201_adc_in(DS2201_1_BASE, 3);
    irp_B.SFunction1_h[3] = (real_T)ds2201_adc_in(DS2201_1_BASE, 4);

    /* S-Function (rti_commonblock): '<S1>/S-Function2' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:ADC Group:GROUP2 */
    irp_B.SFunction2[0] = (real_T)ds2201_adc_in(DS2201_1_BASE, 5);
    irp_B.SFunction2[1] = (real_T)ds2201_adc_in(DS2201_1_BASE, 6);
    irp_B.SFunction2[2] = (real_T)ds2201_adc_in(DS2201_1_BASE, 7);
    irp_B.SFunction2[3] = (real_T)ds2201_adc_in(DS2201_1_BASE, 8);

    /* S-Function (rti_commonblock): '<S1>/S-Function3' */
    /* This comment workarounds a code generation problem */

    /* dSPACE I/O Board DS2201 #1 Unit:ADC Group:GROUP3 */
    irp_B.SFunction3[0] = (real_T)ds2201_adc_in(DS2201_1_BASE, 9);
    irp_B.SFunction3[1] = (real_T)ds2201_adc_in(DS2201_1_BASE, 10);

    /* S-Function (rti_commonblock): '<S1>/S-Function4' */
    /* This comment workarounds a code generation problem */

    /* S-Function (rti_commonblock): '<S1>/S-Function5' */
    /* This comment workarounds a code generation problem */
  }
}

/* Model update function */
void irp_update(void)
{
  real_T *lastU;
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S43>/Memory' */
    irp_DW.Memory_PreviousInput = irp_B.Logic[0];

    /* Update for Memory: '<S21>/Memory' */
    irp_DW.Memory_PreviousInput_o = irp_B.Product;
  }

  /* Update for Derivative: '<S21>/Derivative' */
  if (irp_DW.TimeStampA == (rtInf)) {
    irp_DW.TimeStampA = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA;
  } else if (irp_DW.TimeStampB == (rtInf)) {
    irp_DW.TimeStampB = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB;
  } else if (irp_DW.TimeStampA < irp_DW.TimeStampB) {
    irp_DW.TimeStampA = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA;
  } else {
    irp_DW.TimeStampB = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB;
  }

  *lastU = irp_B.Atan2;

  /* End of Update for Derivative: '<S21>/Derivative' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S21>/Memory1' */
    irp_DW.Memory1_PreviousInput = irp_B.InitAngle;

    /* Update for Memory: '<S4>/Memory' */
    irp_DW.Memory_PreviousInput_l = irp_B.Switch;

    /* Update for Memory: '<S17>/Memory' */
    irp_DW.Memory_PreviousInput_j = irp_B.Switch3;

    /* Update for Memory: '<S17>/Memory1' */
    irp_DW.Memory1_PreviousInput_e = irp_B.Switch4;
  }

  /* Update for RateLimiter: '<S13>/Rate Limiter' */
  irp_DW.PrevY = irp_B.RateLimiter;
  irp_DW.LastMajorTime = irp_M->Timing.t[0];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S44>/Memory' */
    irp_DW.Memory_PreviousInput_m = irp_B.Logic_b[0];

    /* Update for Memory: '<S25>/Memory' */
    irp_DW.Memory_PreviousInput_i = irp_B.Product_a;
  }

  /* Update for Derivative: '<S25>/Derivative' */
  if (irp_DW.TimeStampA_c == (rtInf)) {
    irp_DW.TimeStampA_c = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_o;
  } else if (irp_DW.TimeStampB_j == (rtInf)) {
    irp_DW.TimeStampB_j = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_h;
  } else if (irp_DW.TimeStampA_c < irp_DW.TimeStampB_j) {
    irp_DW.TimeStampA_c = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_o;
  } else {
    irp_DW.TimeStampB_j = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_h;
  }

  *lastU = irp_B.Atan2_h;

  /* End of Update for Derivative: '<S25>/Derivative' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S25>/Memory1' */
    irp_DW.Memory1_PreviousInput_p = irp_B.InitAngle_o;

    /* Update for Memory: '<S6>/Memory' */
    irp_DW.Memory_PreviousInput_g = irp_B.Switch_g;

    /* Update for Memory: '<S5>/Memory' */
    irp_DW.Memory_PreviousInput_a = irp_B.Switch_i;

    /* Update for Memory: '<S5>/Memory1' */
    irp_DW.Memory1_PreviousInput_d = irp_B.Switch1;

    /* Update for Memory: '<S16>/Memory1' */
    irp_DW.Memory1_PreviousInput_h = irp_B.Switch2;
  }

  /* Update for RateLimiter: '<S14>/Rate Limiter' */
  irp_DW.PrevY_p = irp_B.RateLimiter_f;
  irp_DW.LastMajorTime_p = irp_M->Timing.t[0];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S45>/Memory' */
    irp_DW.Memory_PreviousInput_md = irp_B.Logic_f[0];

    /* Update for Memory: '<S29>/Memory' */
    irp_DW.Memory_PreviousInput_e = irp_B.Product_c;
  }

  /* Update for Derivative: '<S29>/Derivative' */
  if (irp_DW.TimeStampA_l == (rtInf)) {
    irp_DW.TimeStampA_l = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_n;
  } else if (irp_DW.TimeStampB_l == (rtInf)) {
    irp_DW.TimeStampB_l = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_c;
  } else if (irp_DW.TimeStampA_l < irp_DW.TimeStampB_l) {
    irp_DW.TimeStampA_l = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_n;
  } else {
    irp_DW.TimeStampB_l = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_c;
  }

  *lastU = irp_B.Atan2_b;

  /* End of Update for Derivative: '<S29>/Derivative' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S29>/Memory1' */
    irp_DW.Memory1_PreviousInput_c = irp_B.InitAngle_k;

    /* Update for Memory: '<S16>/Memory' */
    irp_DW.Memory_PreviousInput_ah = irp_B.Switch1_a;
  }

  /* Update for RateLimiter: '<S15>/Rate Limiter' */
  irp_DW.PrevY_m = irp_B.RateLimiter_c;
  irp_DW.LastMajorTime_l = irp_M->Timing.t[0];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S33>/Memory' */
    irp_DW.Memory_PreviousInput_mg = irp_B.Product_ag;
  }

  /* Update for Derivative: '<S33>/Derivative' */
  if (irp_DW.TimeStampA_h == (rtInf)) {
    irp_DW.TimeStampA_h = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_d;
  } else if (irp_DW.TimeStampB_c == (rtInf)) {
    irp_DW.TimeStampB_c = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_b;
  } else if (irp_DW.TimeStampA_h < irp_DW.TimeStampB_c) {
    irp_DW.TimeStampA_h = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_d;
  } else {
    irp_DW.TimeStampB_c = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_b;
  }

  *lastU = irp_B.Atan2_o;

  /* End of Update for Derivative: '<S33>/Derivative' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S33>/Memory1' */
    irp_DW.Memory1_PreviousInput_n = irp_B.InitAngle_m;
  }

  /* Update for RateLimiter: '<S18>/Rate Limiter4' */
  irp_DW.PrevY_b = irp_B.RateLimiter4;
  irp_DW.LastMajorTime_k = irp_M->Timing.t[0];
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S37>/Memory' */
    irp_DW.Memory_PreviousInput_o4 = irp_B.Product_k;
  }

  /* Update for Derivative: '<S37>/Derivative' */
  if (irp_DW.TimeStampA_k == (rtInf)) {
    irp_DW.TimeStampA_k = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_p;
  } else if (irp_DW.TimeStampB_i == (rtInf)) {
    irp_DW.TimeStampB_i = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_d;
  } else if (irp_DW.TimeStampA_k < irp_DW.TimeStampB_i) {
    irp_DW.TimeStampA_k = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeA_p;
  } else {
    irp_DW.TimeStampB_i = irp_M->Timing.t[0];
    lastU = &irp_DW.LastUAtTimeB_d;
  }

  *lastU = irp_B.Atan2_c;

  /* End of Update for Derivative: '<S37>/Derivative' */
  if (rtmIsMajorTimeStep(irp_M)) {
    /* Update for Memory: '<S37>/Memory1' */
    irp_DW.Memory1_PreviousInput_dv = irp_B.InitAngle_l;
  }

  /* Update for RateLimiter: '<S19>/Rate Limiter3' */
  irp_DW.PrevY_l = irp_B.RateLimiter3;
  irp_DW.LastMajorTime_g = irp_M->Timing.t[0];
  if (rtmIsMajorTimeStep(irp_M)) {
    rt_ertODEUpdateContinuousStates(&irp_M->solverInfo);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++irp_M->Timing.clockTick0)) {
    ++irp_M->Timing.clockTickH0;
  }

  irp_M->Timing.t[0] = rtsiGetSolverStopTime(&irp_M->solverInfo);

  {
    /* Update absolute timer for sample time: [0.001s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++irp_M->Timing.clockTick1)) {
      ++irp_M->Timing.clockTickH1;
    }

    irp_M->Timing.t[1] = irp_M->Timing.clockTick1 * irp_M->Timing.stepSize1 +
      irp_M->Timing.clockTickH1 * irp_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void irp_derivatives(void)
{
  XDot_irp_T *_rtXdot;
  _rtXdot = ((XDot_irp_T *) irp_M->ModelData.derivs);

  /* Derivatives for ZeroPole: '<S22>/Analog Butterworth LP Filter' */
  _rtXdot->AnalogButterworthLPFilter_CSTAT = 0.0;
  _rtXdot->AnalogButterworthLPFilter_CSTAT += irp_P.AnalogButterworthLPFilter_A *
    irp_X.AnalogButterworthLPFilter_CSTAT;
  _rtXdot->AnalogButterworthLPFilter_CSTAT += irp_P.AnalogButterworthLPFilter_B *
    irp_B.SFunction1_h[0];

  /* Derivatives for ZeroPole: '<S23>/Analog Butterworth LP Filter1' */
  _rtXdot->AnalogButterworthLPFilter1_CSTA = 0.0;
  _rtXdot->AnalogButterworthLPFilter1_CSTA += irp_P.AnalogButterworthLPFilter1_A
    * irp_X.AnalogButterworthLPFilter1_CSTA;
  _rtXdot->AnalogButterworthLPFilter1_CSTA += irp_P.AnalogButterworthLPFilter1_B
    * irp_B.SFunction1_h[1];

  /* Derivatives for ZeroPole: '<S26>/Analog Butterworth LP Filter' */
  _rtXdot->AnalogButterworthLPFilter_CST_d = 0.0;
  _rtXdot->AnalogButterworthLPFilter_CST_d +=
    irp_P.AnalogButterworthLPFilter_A_k * irp_X.AnalogButterworthLPFilter_CST_d;
  _rtXdot->AnalogButterworthLPFilter_CST_d +=
    irp_P.AnalogButterworthLPFilter_B_f * irp_B.SFunction1_h[2];

  /* Derivatives for ZeroPole: '<S27>/Analog Butterworth LP Filter1' */
  _rtXdot->AnalogButterworthLPFilter1_CS_n = 0.0;
  _rtXdot->AnalogButterworthLPFilter1_CS_n +=
    irp_P.AnalogButterworthLPFilter1_A_j * irp_X.AnalogButterworthLPFilter1_CS_n;
  _rtXdot->AnalogButterworthLPFilter1_CS_n +=
    irp_P.AnalogButterworthLPFilter1_B_f * irp_B.SFunction1_h[3];

  /* Derivatives for ZeroPole: '<S30>/Analog Butterworth LP Filter' */
  _rtXdot->AnalogButterworthLPFilter_CST_c = 0.0;
  _rtXdot->AnalogButterworthLPFilter_CST_c +=
    irp_P.AnalogButterworthLPFilter_A_e * irp_X.AnalogButterworthLPFilter_CST_c;
  _rtXdot->AnalogButterworthLPFilter_CST_c +=
    irp_P.AnalogButterworthLPFilter_B_fb * irp_B.SFunction2[0];

  /* Derivatives for ZeroPole: '<S31>/Analog Butterworth LP Filter1' */
  _rtXdot->AnalogButterworthLPFilter1_CS_e = 0.0;
  _rtXdot->AnalogButterworthLPFilter1_CS_e +=
    irp_P.AnalogButterworthLPFilter1_A_o * irp_X.AnalogButterworthLPFilter1_CS_e;
  _rtXdot->AnalogButterworthLPFilter1_CS_e +=
    irp_P.AnalogButterworthLPFilter1_B_d * irp_B.SFunction2[1];

  /* Derivatives for ZeroPole: '<S34>/Analog Butterworth LP Filter' */
  _rtXdot->AnalogButterworthLPFilter_CS_dc = 0.0;
  _rtXdot->AnalogButterworthLPFilter_CS_dc +=
    irp_P.AnalogButterworthLPFilter_A_a * irp_X.AnalogButterworthLPFilter_CS_dc;
  _rtXdot->AnalogButterworthLPFilter_CS_dc +=
    irp_P.AnalogButterworthLPFilter_B_o * irp_B.SFunction2[2];

  /* Derivatives for ZeroPole: '<S35>/Analog Butterworth LP Filter1' */
  _rtXdot->AnalogButterworthLPFilter1_CS_c = 0.0;
  _rtXdot->AnalogButterworthLPFilter1_CS_c +=
    irp_P.AnalogButterworthLPFilter1_A_p * irp_X.AnalogButterworthLPFilter1_CS_c;
  _rtXdot->AnalogButterworthLPFilter1_CS_c +=
    irp_P.AnalogButterworthLPFilter1_B_h * irp_B.SFunction2[3];

  /* Derivatives for ZeroPole: '<S38>/Analog Butterworth LP Filter' */
  _rtXdot->AnalogButterworthLPFilter_CST_j = 0.0;
  _rtXdot->AnalogButterworthLPFilter_CST_j +=
    irp_P.AnalogButterworthLPFilter_A_p * irp_X.AnalogButterworthLPFilter_CST_j;
  _rtXdot->AnalogButterworthLPFilter_CST_j +=
    irp_P.AnalogButterworthLPFilter_B_ol * irp_B.SFunction3[0];

  /* Derivatives for ZeroPole: '<S39>/Analog Butterworth LP Filter1' */
  _rtXdot->AnalogButterworthLPFilter1_CS_h = 0.0;
  _rtXdot->AnalogButterworthLPFilter1_CS_h +=
    irp_P.AnalogButterworthLPFilter1_A_b * irp_X.AnalogButterworthLPFilter1_CS_h;
  _rtXdot->AnalogButterworthLPFilter1_CS_h +=
    irp_P.AnalogButterworthLPFilter1_B_l * irp_B.SFunction3[1];
}

/* Model initialize function */
void irp_initialize(void)
{
  /* Start for S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN1' */

  /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
  ds2201_dac_out(DS2201_1_BASE, 1, 0);

  /* Start for S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN2' */

  /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
  ds2201_dac_out(DS2201_1_BASE, 2, 0);

  /* Start for S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN3' */

  /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
  ds2201_dac_out(DS2201_1_BASE, 3, 0);

  /* Start for S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN4' */

  /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP1 */
  ds2201_dac_out(DS2201_1_BASE, 4, 0);

  /* Start for S-Function (rti_commonblock): '<S2>/DS2201DAC_SFCN5' */

  /* dSPACE I/O Board DS2201 #1 Unit:DAC Group:DS2201_GROUP2 */
  ds2201_dac_out(DS2201_1_BASE, 5, 0);

  /* Start for DataStoreMemory: '<Root>/IN_Os_1 ' */
  irp_DW.IN_Os_1 = irp_P.IN_Os_1_InitialValue;

  /* Start for DataStoreMemory: '<Root>/IN_Os_2 ' */
  irp_DW.IN_Os_2 = irp_P.IN_Os_2_InitialValue;

  /* Start for DataStoreMemory: '<Root>/IN_Os_3 ' */
  irp_DW.IN_Os_3 = irp_P.IN_Os_3_InitialValue;

  /* Start for DataStoreMemory: '<Root>/PRED_1 ' */
  irp_DW.PRED_1 = irp_P.PRED_1_InitialValue;

  /* Start for DataStoreMemory: '<Root>/Start_bazowania_IN ' */
  irp_DW.Start_bazowania_IN = irp_P.Start_bazowania_IN_InitialValue;

  /* InitializeConditions for Memory: '<S43>/Memory' */
  irp_DW.Memory_PreviousInput = irp_P.Memory_X0;

  /* InitializeConditions for Memory: '<S21>/Memory' */
  irp_DW.Memory_PreviousInput_o = irp_P.Memory_X0_a;

  /* InitializeConditions for ZeroPole: '<S22>/Analog Butterworth LP Filter' */
  irp_X.AnalogButterworthLPFilter_CSTAT = 0.0;

  /* InitializeConditions for ZeroPole: '<S23>/Analog Butterworth LP Filter1' */
  irp_X.AnalogButterworthLPFilter1_CSTA = 0.0;

  /* InitializeConditions for Derivative: '<S21>/Derivative' */
  irp_DW.TimeStampA = (rtInf);
  irp_DW.TimeStampB = (rtInf);

  /* InitializeConditions for Memory: '<S21>/Memory1' */
  irp_DW.Memory1_PreviousInput = irp_P.Memory1_X0;

  /* InitializeConditions for Memory: '<S4>/Memory' */
  irp_DW.Memory_PreviousInput_l = irp_P.Memory_X0_a5;

  /* InitializeConditions for Memory: '<S17>/Memory' */
  irp_DW.Memory_PreviousInput_j = irp_P.Memory_X0_n;

  /* InitializeConditions for Memory: '<S17>/Memory1' */
  irp_DW.Memory1_PreviousInput_e = irp_P.Memory1_X0_g;

  /* InitializeConditions for RateLimiter: '<S13>/Rate Limiter' */
  irp_DW.LastMajorTime = (rtInf);

  /* InitializeConditions for Memory: '<S44>/Memory' */
  irp_DW.Memory_PreviousInput_m = irp_P.Memory_X0_e;

  /* InitializeConditions for Memory: '<S25>/Memory' */
  irp_DW.Memory_PreviousInput_i = irp_P.Memory_X0_ne;

  /* InitializeConditions for ZeroPole: '<S26>/Analog Butterworth LP Filter' */
  irp_X.AnalogButterworthLPFilter_CST_d = 0.0;

  /* InitializeConditions for ZeroPole: '<S27>/Analog Butterworth LP Filter1' */
  irp_X.AnalogButterworthLPFilter1_CS_n = 0.0;

  /* InitializeConditions for Derivative: '<S25>/Derivative' */
  irp_DW.TimeStampA_c = (rtInf);
  irp_DW.TimeStampB_j = (rtInf);

  /* InitializeConditions for Memory: '<S25>/Memory1' */
  irp_DW.Memory1_PreviousInput_p = irp_P.Memory1_X0_n;

  /* InitializeConditions for Memory: '<S6>/Memory' */
  irp_DW.Memory_PreviousInput_g = irp_P.Memory_X0_c;

  /* InitializeConditions for Memory: '<S5>/Memory' */
  irp_DW.Memory_PreviousInput_a = irp_P.Memory_X0_h;

  /* InitializeConditions for Memory: '<S5>/Memory1' */
  irp_DW.Memory1_PreviousInput_d = irp_P.Memory1_X0_h;

  /* InitializeConditions for Memory: '<S16>/Memory1' */
  irp_DW.Memory1_PreviousInput_h = irp_P.Memory1_X0_l;

  /* InitializeConditions for RateLimiter: '<S14>/Rate Limiter' */
  irp_DW.LastMajorTime_p = (rtInf);

  /* InitializeConditions for Memory: '<S45>/Memory' */
  irp_DW.Memory_PreviousInput_md = irp_P.Memory_X0_j;

  /* InitializeConditions for Memory: '<S29>/Memory' */
  irp_DW.Memory_PreviousInput_e = irp_P.Memory_X0_k;

  /* InitializeConditions for ZeroPole: '<S30>/Analog Butterworth LP Filter' */
  irp_X.AnalogButterworthLPFilter_CST_c = 0.0;

  /* InitializeConditions for ZeroPole: '<S31>/Analog Butterworth LP Filter1' */
  irp_X.AnalogButterworthLPFilter1_CS_e = 0.0;

  /* InitializeConditions for Derivative: '<S29>/Derivative' */
  irp_DW.TimeStampA_l = (rtInf);
  irp_DW.TimeStampB_l = (rtInf);

  /* InitializeConditions for Memory: '<S29>/Memory1' */
  irp_DW.Memory1_PreviousInput_c = irp_P.Memory1_X0_k;

  /* InitializeConditions for Memory: '<S16>/Memory' */
  irp_DW.Memory_PreviousInput_ah = irp_P.Memory_X0_ex;

  /* InitializeConditions for RateLimiter: '<S15>/Rate Limiter' */
  irp_DW.LastMajorTime_l = (rtInf);

  /* InitializeConditions for Memory: '<S33>/Memory' */
  irp_DW.Memory_PreviousInput_mg = irp_P.Memory_X0_l;

  /* InitializeConditions for ZeroPole: '<S34>/Analog Butterworth LP Filter' */
  irp_X.AnalogButterworthLPFilter_CS_dc = 0.0;

  /* InitializeConditions for ZeroPole: '<S35>/Analog Butterworth LP Filter1' */
  irp_X.AnalogButterworthLPFilter1_CS_c = 0.0;

  /* InitializeConditions for Derivative: '<S33>/Derivative' */
  irp_DW.TimeStampA_h = (rtInf);
  irp_DW.TimeStampB_c = (rtInf);

  /* InitializeConditions for Memory: '<S33>/Memory1' */
  irp_DW.Memory1_PreviousInput_n = irp_P.Memory1_X0_p;

  /* InitializeConditions for RateLimiter: '<S18>/Rate Limiter4' */
  irp_DW.LastMajorTime_k = (rtInf);

  /* InitializeConditions for Memory: '<S37>/Memory' */
  irp_DW.Memory_PreviousInput_o4 = irp_P.Memory_X0_kh;

  /* InitializeConditions for ZeroPole: '<S38>/Analog Butterworth LP Filter' */
  irp_X.AnalogButterworthLPFilter_CST_j = 0.0;

  /* InitializeConditions for ZeroPole: '<S39>/Analog Butterworth LP Filter1' */
  irp_X.AnalogButterworthLPFilter1_CS_h = 0.0;

  /* InitializeConditions for Derivative: '<S37>/Derivative' */
  irp_DW.TimeStampA_k = (rtInf);
  irp_DW.TimeStampB_i = (rtInf);

  /* InitializeConditions for Memory: '<S37>/Memory1' */
  irp_DW.Memory1_PreviousInput_dv = irp_P.Memory1_X0_ni;

  /* InitializeConditions for RateLimiter: '<S19>/Rate Limiter3' */
  irp_DW.LastMajorTime_g = (rtInf);
}

/* Model terminate function */
void irp_terminate(void)
{
  /* (no terminate code required) */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  irp_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  irp_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  irp_initialize();
}

void MdlTerminate(void)
{
  irp_terminate();
}

/* Registration function */
RT_MODEL_irp_T *irp(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)irp_M, 0,
                sizeof(RT_MODEL_irp_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&irp_M->solverInfo, &irp_M->Timing.simTimeStep);
    rtsiSetTPtr(&irp_M->solverInfo, &rtmGetTPtr(irp_M));
    rtsiSetStepSizePtr(&irp_M->solverInfo, &irp_M->Timing.stepSize0);
    rtsiSetdXPtr(&irp_M->solverInfo, &irp_M->ModelData.derivs);
    rtsiSetContStatesPtr(&irp_M->solverInfo, (real_T **)
                         &irp_M->ModelData.contStates);
    rtsiSetNumContStatesPtr(&irp_M->solverInfo, &irp_M->Sizes.numContStates);
    rtsiSetErrorStatusPtr(&irp_M->solverInfo, (&rtmGetErrorStatus(irp_M)));
    rtsiSetRTModelPtr(&irp_M->solverInfo, irp_M);
  }

  rtsiSetSimTimeStep(&irp_M->solverInfo, MAJOR_TIME_STEP);
  irp_M->ModelData.intgData.f[0] = irp_M->ModelData.odeF[0];
  irp_M->ModelData.contStates = ((real_T *) &irp_X);
  rtsiSetSolverData(&irp_M->solverInfo, (void *)&irp_M->ModelData.intgData);
  rtsiSetSolverName(&irp_M->solverInfo,"ode1");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = irp_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    irp_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    irp_M->Timing.sampleTimes = (&irp_M->Timing.sampleTimesArray[0]);
    irp_M->Timing.offsetTimes = (&irp_M->Timing.offsetTimesArray[0]);

    /* task periods */
    irp_M->Timing.sampleTimes[0] = (0.0);
    irp_M->Timing.sampleTimes[1] = (0.001);

    /* task offsets */
    irp_M->Timing.offsetTimes[0] = (0.0);
    irp_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(irp_M, &irp_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = irp_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    irp_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(irp_M, -1);
  irp_M->Timing.stepSize0 = 0.001;
  irp_M->Timing.stepSize1 = 0.001;
  irp_M->solverInfoPtr = (&irp_M->solverInfo);
  irp_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&irp_M->solverInfo, 0.001);
  rtsiSetSolverMode(&irp_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  irp_M->ModelData.blockIO = ((void *) &irp_B);
  (void) memset(((void *) &irp_B), 0,
                sizeof(B_irp_T));

  /* parameters */
  irp_M->ModelData.defaultParam = ((real_T *)&irp_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &irp_X;
    irp_M->ModelData.contStates = (x);
    (void) memset((void *)&irp_X, 0,
                  sizeof(X_irp_T));
  }

  /* states (dwork) */
  irp_M->ModelData.dwork = ((void *) &irp_DW);
  (void) memset((void *)&irp_DW, 0,
                sizeof(DW_irp_T));

  {
    /* user code (registration function declaration) */
    /*Initialize global TRC pointers. */
    irp_rti_init_trc_pointers();
  }

  /* Initialize Sizes */
  irp_M->Sizes.numContStates = (10);   /* Number of continuous states */
  irp_M->Sizes.numPeriodicContStates = (0);/* Number of periodic continuous states */
  irp_M->Sizes.numY = (0);             /* Number of model outputs */
  irp_M->Sizes.numU = (0);             /* Number of model inputs */
  irp_M->Sizes.sysDirFeedThru = (0);   /* The model is not direct feedthrough */
  irp_M->Sizes.numSampTimes = (2);     /* Number of sample times */
  irp_M->Sizes.numBlocks = (178);      /* Number of blocks */
  irp_M->Sizes.numBlockIO = (150);     /* Number of block outputs */
  irp_M->Sizes.numBlockPrms = (204);   /* Sum of parameter "widths" */
  return irp_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/

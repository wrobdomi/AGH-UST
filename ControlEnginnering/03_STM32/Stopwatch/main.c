/**
  ******************************************************************************
  * File Name          : main.c
  * Description        : Main program body
  ******************************************************************************
  ** This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * COPYRIGHT(c) 2018 STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "stm32f4xx_hal.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private variables ---------------------------------------------------------*/
TIM_HandleTypeDef htim11;

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/
int counter_1 = 0;
int SEK_1 = 0;
int counter_2 = 0;
int SEK_10 = 0;
int counter_3 = 0;
int MIN_1 = 0;
int counter_4 = 0;
int MIN_10 = 0;
int main_count = 0;
int slow_down = 0;
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_TIM11_Init(void);

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/
void CONV_NUM(int number) // The function converts numbers into 7-SEG display
{
switch(number)
{
case 0 :
                HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
                HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
                HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
                HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_SET);
                HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_SET);
                HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_SET);
                HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_RESET);
                HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break;
case 1 :

				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_RESET);
	            HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
	            HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
	            HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_RESET);
	            HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_RESET);
	            HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_RESET);
	            HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_RESET);
	            HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);

break;
case 2 :

				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
	            HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
	            HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_RESET);
	            HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_SET);
	            HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_SET);
	            HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_RESET);
	            HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_SET);
	            HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);

break;
case 3 :
				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break;
case 4 :
				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break;
case 5:
				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break;
case 6:
				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break ;

case 7:
				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break ;

case 8:
				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break ;

case 9:
				HAL_GPIO_WritePin(SEG_A_GPIO_Port,SEG_A_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_B_GPIO_Port,SEG_B_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_C_GPIO_Port,SEG_C_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_D_GPIO_Port,SEG_D_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_E_GPIO_Port,SEG_E_Pin,GPIO_PIN_RESET);
		        HAL_GPIO_WritePin(SEG_F_GPIO_Port,SEG_F_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_G_GPIO_Port,SEG_G_Pin,GPIO_PIN_SET);
		        HAL_GPIO_WritePin(SEG_DP_GPIO_Port,SEG_DP_Pin,GPIO_PIN_RESET);
break ;

        }
}

void HAL_SYSTICK_Callback() //	INTERRUPT SERVICE - SYSTEM INTERRUPT 1 KHZ
{ // THESE INTERRUPT IS USED TO MOVE VALUES FROM MEMORY TO 7-SEG DISPLAY WITH PROPER FREQENCY

	//slow_down++;
	//if(slow_down==2)
	//{
		main_count++;
		if(main_count<4)
		{
			HAL_GPIO_WritePin(COM1_GPIO_Port, COM1_Pin, GPIO_PIN_RESET);
			HAL_GPIO_WritePin(COM2_GPIO_Port, COM2_Pin, GPIO_PIN_SET);
			HAL_GPIO_WritePin(COM3_GPIO_Port, COM3_Pin, GPIO_PIN_SET);
			HAL_GPIO_WritePin(COM4_GPIO_Port, COM4_Pin, GPIO_PIN_SET);
			CONV_NUM(SEK_1);
		}
		else if(main_count<8)
		{
			HAL_GPIO_WritePin(COM1_GPIO_Port, COM2_Pin, GPIO_PIN_SET);
			HAL_GPIO_WritePin(COM2_GPIO_Port, COM2_Pin, GPIO_PIN_RESET);
			HAL_GPIO_WritePin(COM3_GPIO_Port, COM3_Pin, GPIO_PIN_SET);
			HAL_GPIO_WritePin(COM4_GPIO_Port, COM4_Pin, GPIO_PIN_SET);
			CONV_NUM(SEK_10);
		}
		else if(main_count<12)
		{
			HAL_GPIO_WritePin(COM1_GPIO_Port, COM1_Pin, GPIO_PIN_SET);
			HAL_GPIO_WritePin(COM2_GPIO_Port, COM2_Pin, GPIO_PIN_SET);
			HAL_GPIO_WritePin(COM3_GPIO_Port, COM3_Pin, GPIO_PIN_RESET);
			HAL_GPIO_WritePin(COM4_GPIO_Port, COM4_Pin, GPIO_PIN_SET);
			CONV_NUM(MIN_1);
		}
		//else if(main_count<500)
		//{
		//	HAL_GPIO_WritePin(COM1_GPIO_Port, COM1_Pin, GPIO_PIN_SET);
		//	HAL_GPIO_WritePin(COM2_GPIO_Port, COM2_Pin, GPIO_PIN_SET);
		//	HAL_GPIO_WritePin(COM3_GPIO_Port, COM3_Pin, GPIO_PIN_SET);
		//	HAL_GPIO_WritePin(COM4_GPIO_Port, COM4_Pin, GPIO_PIN_RESET);
		//	CONV_NUM(MIN_10);
		//}
		else
			main_count=0;

	//slow_down = 0;
	//}

}


void  HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim ) // ITRERRUPT SERVICE
{ // THESE INTERRUPTS ARE USED TO GENERATE PROPER VALUES FOR 7-SEG DISPLAY

if  ( htim->Instance == TIM11) // TIM11 is set to 1 Hz and generates interrupt every second
{

	// Counts single seconds
	SEK_1++; // Every interrupt single seconds are incremented
	if( SEK_1 == 10) // If seconds are equal to ten it counts from beginning
	{
		SEK_1=0;
	}

	counter_2++; // Counts tens of seconds
	if( counter_2 == 10) // If ten seconds has passed
	{
		counter_2=0; // Zero counter 2
		SEK_10++; // and increment tens of seconds
		if(SEK_10==6) // If tens of seconds are equal to ten it counts from beginning
		{
			SEK_10=0;
		}
	}

	counter_3++; // Counts single minutes
	if( counter_3 == 60) // If 1 minute has passed
	{
		counter_3=0; // Zero counter
		MIN_1++; // and increment single minutes
		if(MIN_1==10) // If minutes has just turned 10, count from beginning
		{
		MIN_1=0;
		}
	}

	counter_4++; // Counts tens of minutes
	if( counter_4 == 600) // If ten minutes has passed
	{
		counter_4=0; // zero counter
		MIN_10++; // increment tens of minutes
		if(MIN_10==6) // If tens of minutes has just turned 6
		{
		MIN_10=0; //  count from beginning
		}
	}


}


}

/* USER CODE END PFP */

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

int main(void)
{

  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration----------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_TIM11_Init();

  /* USER CODE BEGIN 2 */
  HAL_TIM_Base_Start_IT(&htim11);
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
  /* USER CODE END WHILE */

  /* USER CODE BEGIN 3 */

  }
  /* USER CODE END 3 */

}

/** System Clock Configuration
*/
void SystemClock_Config(void)
{

  RCC_OscInitTypeDef RCC_OscInitStruct;
  RCC_ClkInitTypeDef RCC_ClkInitStruct;

    /**Configure the main internal regulator output voltage 
    */
  __HAL_RCC_PWR_CLK_ENABLE();

  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = 16;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;
  RCC_OscInitStruct.PLL.PLLM = 8;
  RCC_OscInitStruct.PLL.PLLN = 100;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = 4;
  RCC_OscInitStruct.PLL.PLLR = 2;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_3) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Configure the Systick interrupt time 
    */
  HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq()/1000);

    /**Configure the Systick 
    */
  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

  /* SysTick_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}

/* TIM11 init function */
static void MX_TIM11_Init(void)
{

  htim11.Instance = TIM11;
  htim11.Init.Prescaler = 10000;
  htim11.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim11.Init.Period = 10000;
  htim11.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  if (HAL_TIM_Base_Init(&htim11) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

}

/** Configure pins as 
        * Analog 
        * Input 
        * Output
        * EVENT_OUT
        * EXTI
     PA2   ------> USART2_TX
     PA3   ------> USART2_RX
*/
static void MX_GPIO_Init(void)
{

  GPIO_InitTypeDef GPIO_InitStruct;

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOC_CLK_ENABLE();
  __HAL_RCC_GPIOH_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOC, SEG_G_Pin|SEG_D_Pin|SEG_E_Pin|SEG_C_Pin 
                          |SEG_B_Pin|SEG_F_Pin|SEG_A_Pin|SEG_DP_Pin, GPIO_PIN_RESET);

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(LD2_GPIO_Port, LD2_Pin, GPIO_PIN_RESET);

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOC, COM1_Pin|COM2_Pin|COM3_Pin|COM4_Pin, GPIO_PIN_SET);

  /*Configure GPIO pin : B1_Pin */
  GPIO_InitStruct.Pin = B1_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_IT_FALLING;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  HAL_GPIO_Init(B1_GPIO_Port, &GPIO_InitStruct);

  /*Configure GPIO pins : SEG_G_Pin SEG_D_Pin SEG_E_Pin SEG_C_Pin 
                           SEG_B_Pin SEG_F_Pin SEG_A_Pin SEG_DP_Pin 
                           COM1_Pin COM2_Pin COM3_Pin COM4_Pin */
  GPIO_InitStruct.Pin = SEG_G_Pin|SEG_D_Pin|SEG_E_Pin|SEG_C_Pin 
                          |SEG_B_Pin|SEG_F_Pin|SEG_A_Pin|SEG_DP_Pin 
                          |COM1_Pin|COM2_Pin|COM3_Pin|COM4_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

  /*Configure GPIO pins : USART_TX_Pin USART_RX_Pin */
  GPIO_InitStruct.Pin = USART_TX_Pin|USART_RX_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_VERY_HIGH;
  GPIO_InitStruct.Alternate = GPIO_AF7_USART2;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pin : LD2_Pin */
  GPIO_InitStruct.Pin = LD2_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(LD2_GPIO_Port, &GPIO_InitStruct);

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @param  None
  * @retval None
  */
void _Error_Handler(char * file, int line)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  while(1) 
  {
  }
  /* USER CODE END Error_Handler_Debug */ 
}

#ifdef USE_FULL_ASSERT

/**
   * @brief Reports the name of the source file and the source line number
   * where the assert_param error has occurred.
   * @param file: pointer to the source file name
   * @param line: assert_param error line source number
   * @retval None
   */
void assert_failed(uint8_t* file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
    ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */

}

#endif

/**
  * @}
  */ 

/**
  * @}
*/ 

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

/*
  +-----------------------------------------------------------------------+
  | (C) ADDI-DATA GmbH          Dieselstrasse 3      D-77833 Ottersweier  |
  +-----------------------------------------------------------------------+
  | Tel : +49-(0)7223/94930                                               |
  | Fax : +49-(0)7223/949392                                              |
  +-------------------------------+---------------------------------------+
  | Project   : -                 |     Compiler   : BORLANDC/MICROSOFT C |
  | Modulname : APCI1710.H        |     Version    : 3.1     / 6.0        |
  |                               |                                       |
  |                               |                                       |
  +-------------------------------+---------------------------------------+
  | Author : Weber S.                      Date :14/12/94                 |
  +-----------------------------------------------------------------------+
  | Description   : Driver APCI1710                                       |
  |                                                                       |
  +-----------------------------------------------------------------------+
  |                             UPDATE'S                                  |
  +----------+-----------+------------------------------------------------+
  |   Date   |   Author  |          Description of updates                |
  +----------+-----------+------------------------------------------------+
  +----------+-----------+------------------------------------------------+
*/

#ifndef _INT_
   #include <windows.h>

   #define DLL_COMPILER_C          0
   #define DLL_COMPILER_PASCAL     1
   #define DLL_COMPILER_VB         2

   #ifdef _BORLANDC_
      #ifdef __cplusplus

	 /**********************/
	 /* Windows C++ define */
	 /**********************/

	 #define _INT_         extern "C"  _import int far _stdcall
	 #define _VOID_        extern "C"  _import void far _stdcall
      #else

	 /******************/
	 /* Windows define */
	 /******************/

	 #define _INT_         _import int far _stdcall
	 #define _VOID_        _import void far _stdcall
      #endif
   #else
      #ifdef __cplusplus

	 /**********************/
	 /* Windows C++ define */
	 /**********************/

	 #define _INT_         extern "C"  int far _stdcall
	 #define _VOID_        extern "C"  void far _stdcall
      #else

	 /******************/
	 /* Windows define */
	 /******************/

	 #define _INT_         int far _stdcall
	 #define _VOID_        void far _stdcall
      #endif
   #endif

   #define INT_      int
   #define UINT_     unsigned int
   #define BYTE_     unsigned char
   #define CHAR_     char
   #define LONG_     long
   #define ULONG_    unsigned long
   #define PINT_     INT_   *
   #define PUINT_    UINT_  *
   #define PBYTE_    BYTE_  *
   #define PCHAR_    CHAR_  *
   #define PLONG_    LONG_  *
   #define PULONG_   ULONG_ *
#endif

#ifndef      APCI1710
#define      APCI1710
#define      APCI1710_DISABLE             0
#define      APCI1710_ENABLE              1

_INT_        i_APCI1710_InitCompiler              (BYTE_ b_CompilerDefine);

_INT_        i_APCI1710_CheckAndGetPCISlotNumber  (PBYTE_ pb_SlotNumberArray);

_INT_        i_APCI1710_SetBoardInformation       (BYTE_   b_SlotNumber,
						   PBYTE_ pb_BoardHandle);

_INT_        i_APCI1710_GetHardwareInformation    (BYTE_     b_BoardHandle,
						   PUINT_  pui_BaseAddress,
						   PBYTE_  pb_InterruptNbr,
						   PBYTE_  pb_SlotNumber);

_INT_	     i_APCI1710_GetFunctionality	  (BYTE_    b_BoardHandle,
						   BYTE_    b_ModuleNbr,
						   PUINT_ pui_Functionality);

_INT_        i_APCI1710_CloseBoardHandle          (BYTE_ b_BoardHandle);


/*
+----------------------------------------------------------------------------+
|   1710INT.C                                                                |
+----------------------------------------------------------------------------+
*/

#define      APCI1710_SYNCHRONOUS_MODE      1
#define      APCI1710_ASYNCHRONOUS_MODE     0

_INT_   i_APCI1710_SetBoardIntRoutineWin32        (BYTE_     b_BoardHandle,
						   BYTE_     b_UserCallingMode,
						   ULONG_   ul_GlobalBufferSize,
						   VOID ** ppv_UserGloablBuffer,
						   void (far pascal * v_FunctionName) (BYTE_  b_BoardHandle,
										       BYTE_  b_ModuleMask,
										       ULONG_ ul_InterruptMask,
										       ULONG_ ul_CounterLatchValue,
										       BYTE_   b_UserCallingMode,
										       VOID * pv_UserSharedMemory));

_INT_        i_APCI1710_TestInterrupt              (PBYTE_   pb_BoardHandle,
						    PBYTE_   pb_ModuleMask,
						    PULONG_ pul_InterruptMask,
						    PULONG_ pul_CounterLatchValue);

_INT_        i_APCI1710_ResetBoardIntRoutine       (BYTE_ b_BoardHandle);

/*
+----------------------------------------------------------------------------+
|   INC_CPT.C                                                                |
+----------------------------------------------------------------------------+
*/

#define      APCI1710_16BIT_COUNTER   0x10
#define      APCI1710_32BIT_COUNTER   0x0
#define      APCI1710_QUADRUPLE_MODE  0x0
#define      APCI1710_DOUBLE_MODE     0x3
#define      APCI1710_SIMPLE_MODE     0xF
#define      APCI1710_DIRECT_MODE     0x80
#define      APCI1710_HYSTERESIS_ON   0x60
#define      APCI1710_HYSTERESIS_OFF  0x0
#define      APCI1710_INCREMENT       0x60
#define      APCI1710_DECREMENT       0x0
#define      APCI1710_LATCH_COUNTER   0x1
#define      APCI1710_CLEAR_COUNTER   0x0
#define      APCI1710_LOW             0x0
#define      APCI1710_HIGH            0x1

/*********************/
/* Version 0600-0229 */
/*********************/

#define APCI1710_HIGH_EDGE_CLEAR_COUNTER 		0x0
#define APCI1710_HIGH_EDGE_LATCH_COUNTER 		0x1
#define APCI1710_LOW_EDGE_CLEAR_COUNTER  		0x2
#define APCI1710_LOW_EDGE_LATCH_COUNTER  		0x3
#define APCI1710_HIGH_EDGE_LATCH_AND_CLEAR_COUNTER 	0x4
#define APCI1710_LOW_EDGE_LATCH_AND_CLEAR_COUNTER 	0x5
#define APCI1710_SOURCE_0				0x0
#define APCI1710_SOURCE_1				0x1


_INT_   i_APCI1710_InitCounter          (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_CounterRange,
					 BYTE_ b_FirstCounterModus,
					 BYTE_ b_FirstCounterOption,
					 BYTE_ b_SecondCounterModus,
					 BYTE_ b_SecondCounterOption);

_INT_   i_APCI1710_CounterAutoTest      (BYTE_   b_BoardHandle,
					 PBYTE_ pb_TestStatus);

_INT_   i_APCI1710_ClearCounterValue    (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr);

_INT_   i_APCI1710_ClearAllCounterValue (BYTE_ b_BoardHandle);

_INT_ 	i_APCI1710_SetInputFilter     	(BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_PCIInputClock,
					 BYTE_ b_Filter);


/*
+----------------------------------------------------------------------------+
|                       READ COUNTER FUNCTIONS                               |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_LatchCounter                 (BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr,
						 BYTE_ b_LatchReg);

_INT_   i_APCI1710_ReadLatchRegisterStatus      (BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 BYTE_   b_LatchReg,
						 PBYTE_ pb_LatchStatus);

_INT_   i_APCI1710_ReadLatchRegisterValue       (BYTE_     b_BoardHandle,
						 BYTE_     b_ModulNbr,
						 BYTE_     b_LatchReg,
						 PULONG_ pul_LatchValue);

_INT_   i_APCI1710_EnableLatchInterrupt         (BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr);

_INT_   i_APCI1710_DisableLatchInterrupt        (BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr);

_INT_   i_APCI1710_Read16BitCounterValue        (BYTE_    b_BoardHandle,
						 BYTE_    b_ModulNbr,
						 BYTE_    b_SelectedCounter,
						 PUINT_ pui_CounterValue);

_INT_   i_APCI1710_Read32BitCounterValue        (BYTE_      b_BoardHandle,
						 BYTE_      b_ModulNbr,
						 PULONG_  pul_CounterValue);

/*
+----------------------------------------------------------------------------+
|                       WRITE COUNTER FUNCTIONS                              |
+----------------------------------------------------------------------------+
*/


_INT_   i_APCI1710_Write16BitCounterValue       (BYTE_  b_BoardHandle,
						 BYTE_  b_ModulNbr,
						 BYTE_  b_SelectedCounter,
						 UINT_ ui_WriteValue);

_INT_   i_APCI1710_Write32BitCounterValue       (BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 ULONG_ ul_WriteValue);

/*
+----------------------------------------------------------------------------+
|                            INDEX FUNCTIONS                                 |
+----------------------------------------------------------------------------+
*/


_INT_   i_APCI1710_InitIndex            	(BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr,
						 BYTE_ b_ReferenceAction,
						 BYTE_ b_IndexOperation,
						 BYTE_ b_AutoMode,
						 BYTE_ b_InterruptEnable);

_INT_   i_APCI1710_EnableIndex          	(BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr);

_INT_   i_APCI1710_DisableIndex         	(BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr);

_INT_   i_APCI1710_GetIndexStatus      		(BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 PBYTE_ pb_IndexStatus);

_INT_	i_APCI1710_SetIndexAndReferenceSource	(BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr,
						 BYTE_ b_SourceSelection);

/*
+----------------------------------------------------------------------------+
|                            REFERENCE FUNCTIONS                             |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitReference        (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_ReferenceLevel);

_INT_   i_APCI1710_GetReferenceStatus      (BYTE_   b_BoardHandle,
					    BYTE_   b_ModulNbr,
					    PBYTE_ pb_ReferenceStatus);

/*
+----------------------------------------------------------------------------+
|                            UAS,CBx,U/D# FUNCTIONS                          |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_GetUASStatus 		(BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 PBYTE_ pb_UASStatus);

_INT_   i_APCI1710_GetCBStatus  		(BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 PBYTE_ pb_CBStatus);

_INT_ 	i_APCI1710_Get16BitCBStatus		(BYTE_     b_BoardHandle,
						 BYTE_     b_ModulNbr,
						 PBYTE_ pb_CBStatusCounter0,
						 PBYTE_ pb_CBStatusCounter1);

_INT_   i_APCI1710_GetUDStatus  		(BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 PBYTE_ pb_UDStatus);

_INT_   i_APCI1710_GetInterruptUDLatchedStatus	(BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 PBYTE_ pb_UDStatus);

_INT_	i_APCI1710_InitExternalStrobe		(BYTE_ b_BoardHandle,
						 BYTE_ b_ModulNbr,
						 BYTE_ b_ExternalStrobe,
						 BYTE_ b_ExternalStrobeLevel);

/*
+----------------------------------------------------------------------------+
|                            Compare FUNCTIONS                               |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitCompareLogic	(BYTE_   b_BoardHandle,
					 BYTE_   b_ModulNbr,
					 UINT_  ui_CompareValue);

_INT_   i_APCI1710_EnableCompareLogic	(BYTE_   b_BoardHandle,
					 BYTE_   b_ModulNbr);

_INT_   i_APCI1710_DisableCompareLogic	(BYTE_   b_BoardHandle,
					 BYTE_   b_ModulNbr);


/*
+----------------------------------------------------------------------------+
|                       Frequency measurement FUNCTIONS                      |
+----------------------------------------------------------------------------+
*/

_INT_	i_APCI1710_InitFrequencyMeasurement	(BYTE_		 b_BoardHandle,
						 BYTE_		 b_ModulNbr,
						 BYTE_		 b_PCIInputClock,
						 BYTE_		 b_TimingUnity,
						 ULONG_ 	ul_TimingInterval,
						 PULONG_       pul_RealTimingInterval);

_INT_	i_APCI1710_EnableFrequencyMeasurement	(BYTE_	 b_BoardHandle,
						 BYTE_	 b_ModulNbr,
						 BYTE_ 	 b_InterruptEnable);

_INT_	i_APCI1710_ReadFrequencyMeasurement (BYTE_	 b_BoardHandle,
					     BYTE_	 b_ModulNbr,
					     PBYTE_	pb_Status,
					     PBYTE_	pb_UDStatus,
					     PULONG_   pul_ReadValue);

_INT_	i_APCI1710_DisableFrequencyMeasurement	(BYTE_	 b_BoardHandle,
						 BYTE_	 b_ModulNbr);

/*
+----------------------------------------------------------------------------+
|                       Digital output FUNCTIONS                             |
+----------------------------------------------------------------------------+
*/

_INT_	i_APCI1710_SetDigitalChlOn 		(BYTE_  b_BoardHandle,
						 BYTE_  b_ModulNbr);

_INT_	i_APCI1710_SetDigitalChlOff 		(BYTE_  b_BoardHandle,
						 BYTE_  b_ModulNbr);

/*
+----------------------------------------------------------------------------+
|                            KRNL FUNCTIONS                                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_ClearCounterValue       (UINT_ ui_BaseAddress,
						 BYTE_  b_ModulNbr);

_INT_   i_APCI1710_KRNL_ReadLatchRegisterValue (UINT_   ui_BaseAddress,
						 BYTE_     b_ModulNbr,
						 BYTE_     b_LatchReg,
						 PULONG_ pul_LatchValue);

_INT_   i_APCI1710_KRNL_Read16BitCounterValue   (UINT_   ui_BaseAddress,
						 BYTE_    b_ModulNbr,
						 BYTE_    b_SelectedCounter,
						 PUINT_ pui_CounterValue);

_INT_   i_APCI1710_KRNL_Read32BitCounterValue   (UINT_     ui_BaseAddress,
						 BYTE_      b_ModulNbr,
						 PULONG_  pul_CounterValue);

_INT_   i_APCI1710_KRNL_Write16BitCounterValue  (UINT_ ui_BaseAddress,
						 BYTE_  b_ModulNbr,
						 BYTE_  b_SelectedCounter,
						 UINT_ ui_WriteValue);

_INT_   i_APCI1710_KRNL_Write32BitCounterValue  (UINT_  ui_BaseAddress,
						 BYTE_   b_ModulNbr,
						 ULONG_ ul_WriteValue);

_INT_   i_APCI1710_KRNL_ReadFrequencyMeasurement (UINT_    ui_BaseAddress,
						  BYTE_	    b_ModulNbr,
						  PBYTE_   pb_Status,
						  PBYTE_   pb_UDStatus,
						  PULONG_ pul_ReadValue);

_INT_   i_APCI1710_KRNL_SetDigitalChlOn 	 (UINT_  ui_BaseAddress,
						  BYTE_   b_ModulNbr);

_INT_   i_APCI1710_KRNL_SetDigitalChlOff 	 (UINT_  ui_BaseAddress,
						  BYTE_   b_ModulNbr);

_INT_   i_APCI1710_KRNL_InitCompareLogic         (UINT_  ui_BaseAddress,
						  BYTE_   b_ModulNbr,
						  UINT_  ui_CompareValue);

/*
+----------------------------------------------------------------------------+
|  SSI.C                                                                     |
+----------------------------------------------------------------------------+
*/


#define APCI1710_30MHZ           30
#define APCI1710_33MHZ           33
#define APCI1710_40MHZ           40
#define APCI1710_10MHZ           10
#define APCI1710_BINARY_MODE     0x1
#define APCI1710_GRAY_MODE       0x0

/*
+----------------------------------------------------------------------------+
|                       SSI INISIALISATION FUNCTION                          |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitSSI              (BYTE_    b_BoardHandle,
					 BYTE_    b_ModulNbr,
					 BYTE_    b_SSIProfile,
					 BYTE_    b_PositionTurnLength,
					 BYTE_    b_TurnCptLength,
					 BYTE_    b_PCIInputClock,
					 ULONG_  ul_SSIOutputClock,
					 BYTE_    b_SSICountingMode);

_INT_   i_APCI1710_Read1SSIValue        (BYTE_     b_BoardHandle,
					 BYTE_     b_ModulNbr,
					 BYTE_     b_SelectedSSI,
					 PULONG_ pul_Position,
					 PULONG_ pul_TurnCpt);


_INT_   i_APCI1710_ReadAllSSIValue      (BYTE_     b_BoardHandle,
					 BYTE_     b_ModulNbr,
					 PULONG_ pul_Position,
					 PULONG_ pul_TurnCpt);

_INT_   i_APCI1710_ReadSSI1DigitalInput    (BYTE_    b_BoardHandle,
					    BYTE_    b_ModulNbr,
					    BYTE_    b_InputChannel,
					    PBYTE_  pb_ChannelStatus);

_INT_   i_APCI1710_ReadSSIAllDigitalInput  (BYTE_     b_BoardHandle,
					    BYTE_     b_ModulNbr,
					    PBYTE_   pb_InputStatus);

_INT_   i_APCI1710_SetSSIDigitalOutputOn   (BYTE_     b_BoardHandle,
					    BYTE_     b_ModulNbr);

_INT_   i_APCI1710_SetSSIDigitalOutputOff  (BYTE_     b_BoardHandle,
					    BYTE_     b_ModulNbr);

/*
+----------------------------------------------------------------------------+
|                            SSI KRNL FUNCTIONS                              |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_ReadSSI1DigitalInput   (UINT_   ui_BaseAddress,
						BYTE_    b_ModulNbr,
						BYTE_    b_InputChannel,
						PBYTE_  pb_ChannelStatus);

_INT_   i_APCI1710_KRNL_ReadSSIAllDigitalInput (UINT_    ui_BaseAddress,
						BYTE_     b_ModulNbr,
						PBYTE_   pb_InputStatus);

_INT_   i_APCI1710_KRNL_SetSSIDigitalOutputOn  (UINT_    ui_BaseAddress,
						BYTE_     b_ModulNbr);

_INT_   i_APCI1710_KRNL_SetSSIDigitalOutputOff  (UINT_    ui_BaseAddress,
						 BYTE_     b_ModulNbr);

/*
+----------------------------------------------------------------------------+
| TTL.C                                                                      |
+----------------------------------------------------------------------------+
*/


/*
+----------------------------------------------------------------------------+
|                       TTL INISIALISATION FUNCTION                          |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitTTLIO    	(BYTE_    b_BoardHandle,
					 BYTE_    b_ModulNbr);

_INT_   i_APCI1710_InitTTLIODirection	(BYTE_    b_BoardHandle,
					 BYTE_    b_ModulNbr,
					 BYTE_    b_PortAMode,
					 BYTE_    b_PortBMode,
					 BYTE_    b_PortCMode,
					 BYTE_    b_PortDMode);

/*
+----------------------------------------------------------------------------+
|                       TTL INPUT FUNCTION                                   |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_ReadTTLIOChannelValue  (BYTE_    b_BoardHandle,
					   BYTE_    b_ModulNbr,
					   BYTE_    b_SelectedPort,
					   BYTE_    b_InputChannel,
					   PBYTE_  pb_ChannelStatus);

_INT_   i_APCI1710_ReadTTLIOPortValue     (BYTE_     b_BoardHandle,
					   BYTE_     b_ModulNbr,
					   BYTE_     b_SelectedPort,
					   PBYTE_   pb_PortValue);

_INT_   i_APCI1710_ReadTTLIOAllPortValue  (BYTE_     b_BoardHandle,
					   BYTE_     b_ModulNbr,
					   PULONG_ pul_PortValue);

/*
+----------------------------------------------------------------------------+
|                            TTL OUTPUT FUNCTIONS                            |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_SetTTLIOChlOn        (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_OutputChannel);

_INT_   i_APCI1710_SetTTLIOChlOff       (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_OutputChannel);


/*
+----------------------------------------------------------------------------+
|                            TTL KRNL FUNCTIONS                              |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_ReadTTLIOChannelValue  (UINT_   ui_BaseAddress,
						BYTE_    b_ModulNbr,
						BYTE_    b_SelectedPort,
						BYTE_    b_InputChannel,
						PBYTE_  pb_ChannelStatus);

_INT_   i_APCI1710_KRNL_ReadTTLIOPortValue  (UINT_   ui_BaseAddress,
					     BYTE_     b_ModulNbr,
					     BYTE_     b_SelectedPort,
					     PBYTE_   pb_PortValue);

_INT_   i_APCI1710_KRNL_ReadTTLIOAllPortValue   (UINT_   ui_BaseAddress,
						 BYTE_     b_ModulNbr,
						 PULONG_ pul_PortValue);

_INT_   i_APCI1710_KRNL_SetTTLIOChlOn           (UINT_ ui_BaseAddress,
						 BYTE_  b_ModulNbr,
						 BYTE_  b_OutputChannel);

_INT_   i_APCI1710_KRNL_SetTTLIOChlOff          (UINT_ ui_BaseAddress,
						 BYTE_  b_ModulNbr,
						 BYTE_  b_OutputChannel);

/*
+----------------------------------------------------------------------------+
| DIG_IO.C                                                                   |
+----------------------------------------------------------------------------+
*/


/*
+----------------------------------------------------------------------------+
|                       DIGITAL I/O INISIALISATION FUNCTION                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitDigitalIO    (BYTE_    b_BoardHandle,
				     BYTE_    b_ModulNbr,
				     BYTE_    b_ChannelAMode,
				     BYTE_    b_ChannelBMode);

/*
+----------------------------------------------------------------------------+
|                            INPUT FUNCTIONS                                 |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_ReadDigitalIOChlValue      (BYTE_    b_BoardHandle,
					       BYTE_    b_ModulNbr,
					       BYTE_    b_InputChannel,
					       PBYTE_  pb_ChannelStatus);

_INT_   i_APCI1710_ReadDigitalIOPortValue     (BYTE_     b_BoardHandle,
					       BYTE_     b_ModulNbr,
					       PBYTE_   pb_PortValue);

/*
+----------------------------------------------------------------------------+
|                            OUTPUT FUNCTIONS                                |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_SetDigitalIOMemoryOn        (BYTE_   b_BoardHandle,
						BYTE_   b_ModulNbr);

_INT_   i_APCI1710_SetDigitalIOMemoryOff       (BYTE_   b_BoardHandle,
						BYTE_   b_ModulNbr);

_INT_   i_APCI1710_SetDigitalIOChlOn           (BYTE_ b_BoardHandle,
						BYTE_ b_ModulNbr,
						BYTE_ b_OutputChannel);

_INT_   i_APCI1710_SetDigitalIOChlOff          (BYTE_ b_BoardHandle,
						BYTE_ b_ModulNbr,
						BYTE_ b_OutputChannel);

_INT_   i_APCI1710_SetDigitalIOPortOn          (BYTE_ b_BoardHandle,
						BYTE_ b_ModulNbr,
						BYTE_ b_PortValue);

_INT_   i_APCI1710_SetDigitalIOPortOff         (BYTE_ b_BoardHandle,
						BYTE_ b_ModulNbr,
						BYTE_ b_PortValue);

/*
+----------------------------------------------------------------------------+
|                            KRNL FUNCTIONS                                  |
+----------------------------------------------------------------------------+
*/

/*
+----------------------------------------------------------------------------+
|                            INPUT FUNCTIONS                                 |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_ReadDigitalIOChlValue      (UINT_   ui_BaseAddress,
						    BYTE_    b_ModulNbr,
						    BYTE_    b_InputChannel,
						    PBYTE_  pb_ChannelStatus);

_INT_   i_APCI1710_KRNL_ReadDigitalIOPortValue     (UINT_   ui_BaseAddress,
						    BYTE_     b_ModulNbr,
						    PBYTE_   pb_PortValue);

/*
+----------------------------------------------------------------------------+
|                            OUTPUT FUNCTIONS                                |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_SetDigitalIOChlOn            (UINT_ ui_BaseAddress,
						      BYTE_  b_ModulNbr,
						      BYTE_  b_OutputChannel);

_INT_   i_APCI1710_KRNL_SetDigitalIOPortOn           (UINT_ ui_BaseAddress,
						      BYTE_  b_ModulNbr,
						      BYTE_  b_PortValue);

/*
+----------------------------------------------------------------------------+
| 82X54.C                                                                    |
+----------------------------------------------------------------------------+
*/

#define APCI1710_PCI_BUS_CLOCK          0
#define APCI1710_FRONT_CONNECTOR_INPUT  1

/*
+----------------------------------------------------------------------------+
|                       82X54 TIMER INISIALISATION FUNCTION                  |
+----------------------------------------------------------------------------+
*/


_INT_   i_APCI1710_InitTimer    (BYTE_   b_BoardHandle,
				 BYTE_   b_ModulNbr,
				 BYTE_   b_TimerNbr,
				 BYTE_   b_TimerMode,
				 ULONG_ ul_ReloadValue,
				 BYTE_   b_InputClockSelection,
				 BYTE_   b_InputClockLevel,
				 BYTE_   b_OutputLevel,
				 BYTE_   b_HardwareGateLevel);

_INT_   i_APCI1710_EnableTimer  (BYTE_ b_BoardHandle,
				 BYTE_ b_ModulNbr,
				 BYTE_ b_TimerNbr,
				 BYTE_ b_InterruptEnable);

_INT_   i_APCI1710_DisableTimer (BYTE_ b_BoardHandle,
				 BYTE_ b_ModulNbr,
				 BYTE_ b_TimerNbr);

/*
+----------------------------------------------------------------------------+
|                       82X54 READ FUNCTION                                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_ReadTimerValue               (BYTE_     b_BoardHandle,
						 BYTE_     b_ModulNbr,
						 BYTE_     b_TimerNbr,
						 PULONG_ pul_TimerValue);

_INT_   i_APCI1710_ReadAllTimerValue            (BYTE_     b_BoardHandle,
						 BYTE_     b_ModulNbr,
						 PULONG_ pul_TimerValueArray);

_INT_   i_APCI1710_GetTimerOutputLevel          (BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 BYTE_   b_TimerNbr,
						 PBYTE_ pb_OutputLevel);

_INT_   i_APCI1710_GetTimerProgressStatus       (BYTE_   b_BoardHandle,
						 BYTE_   b_ModulNbr,
						 BYTE_   b_TimerNbr,
						 PBYTE_ pb_TimerStatus);

/*
+----------------------------------------------------------------------------+
|                       82X54 WRITE FUNCTION                                 |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_WriteTimerValue      (BYTE_   b_BoardHandle,
					 BYTE_   b_ModulNbr,
					 BYTE_   b_TimerNbr,
					 ULONG_ ul_WriteValue);

/*
+----------------------------------------------------------------------------+
|                       82X54 KRNL FUNCTION                                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_ReadTimerValue          (UINT_    ui_BaseAddress,
						 BYTE_     b_ModulNbr,
						 BYTE_     b_TimerNbr,
						 PULONG_ pul_TimerValue);

_INT_   i_APCI1710_KRNL_ReadAllTimerValue       (UINT_    ui_BaseAddress,
						 BYTE_     b_ModulNbr,
						 PULONG_ pul_TimerValueArray);

_INT_   i_APCI1710_KRNL_WriteTimerValue         (UINT_  ui_BaseAddress,
						 BYTE_   b_ModulNbr,
						 BYTE_   b_TimerNbr,
						 ULONG_ ul_WriteValue);

/*
+----------------------------------------------------------------------------+
| CHRONO.C                                                                   |
+----------------------------------------------------------------------------+
*/

#define APCI1710_SINGLE     0
#define APCI1710_CONTINUOUS 1

/*
+----------------------------------------------------------------------------+
|                       CHRONOMETER INISIALISATION FUNCTION                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitChrono           (BYTE_     b_BoardHandle,
					 BYTE_     b_ModulNbr,
					 BYTE_     b_ChronoMode,
					 BYTE_     b_PCIInputClock,
					 BYTE_     b_TimingUnity,
					 ULONG_   ul_TimingInterval,
					 PULONG_ pul_RealTimingInterval);

_INT_   i_APCI1710_EnableChrono         (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_CycleMode,
					 BYTE_ b_InterruptEnable);


_INT_   i_APCI1710_DisableChrono        (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr);

/*
+----------------------------------------------------------------------------+
|                       CHRONOMETER READ FUNCTION                            |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_GetChronoProgressStatus      (BYTE_    b_BoardHandle,
						 BYTE_    b_ModulNbr,
						 PBYTE_  pb_ChronoStatus);

_INT_   i_APCI1710_ReadChronoValue              (BYTE_     b_BoardHandle,
						 BYTE_     b_ModulNbr,
						 UINT_    ui_TimeOut,
						 PBYTE_   pb_ChronoStatus,
						 PULONG_ pul_ChronoValue);


_INT_ i_APCI1710_ConvertChronoValue             (BYTE_     b_BoardHandle,
						 BYTE_     b_ModulNbr,
						 ULONG_   ul_ChronoValue,
						 PULONG_ pul_Hour,
						 PBYTE_   pb_Minute,
						 PBYTE_   pb_Second,
						 PUINT_  pui_MilliSecond,
						 PUINT_  pui_MicroSecond,
						 PUINT_  pui_NanoSecond);

/*
+----------------------------------------------------------------------------+
|                       CHRONOMETER DIGITAL OUTPUT FUNCTION                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_SetChronoChlOn       (BYTE_  b_BoardHandle,
					 BYTE_  b_ModulNbr,
					 BYTE_  b_OutputChannel);


_INT_   i_APCI1710_SetChronoChlOff      (BYTE_  b_BoardHandle,
					 BYTE_  b_ModulNbr,
					 BYTE_  b_OutputChannel);

/*
+----------------------------------------------------------------------------+
|                       CHRONOMETER DIGITAL INPUT FUNCTION                   |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_ReadChronoChlValue   (BYTE_   b_BoardHandle,
					 BYTE_   b_ModulNbr,
					 BYTE_   b_InputChannel,
					 PBYTE_ pb_ChannelStatus);

_INT_   i_APCI1710_ReadChronoPortValue  (BYTE_   b_BoardHandle,
					 BYTE_   b_ModulNbr,
					 PBYTE_ pb_PortValue);

/*
+----------------------------------------------------------------------------+
|                       CHRONOMETER KRNL FUNCTION                            |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_GetChronoProgressStatus (UINT_   ui_BaseAddress,
						 BYTE_    b_ModulNbr,
						 PBYTE_  pb_ChronoStatus);

_INT_   i_APCI1710_KRNL_ReadChronoValue         (UINT_    ui_BaseAddress,
						 BYTE_     b_ModulNbr,
						 PBYTE_   pb_ChronoStatus,
						 PULONG_ pul_ChronoValue);

_INT_   i_APCI1710_KRNL_SetChronoChlOn          (UINT_ ui_BaseAddress,
						 BYTE_  b_ModulNbr,
						 BYTE_  b_OutputChannel);

_INT_   i_APCI1710_KRNL_SetChronoChlOff         (UINT_ ui_BaseAddress,
						 BYTE_  b_ModulNbr,
						 BYTE_  b_OutputChannel);

_INT_   i_APCI1710_KRNL_ReadChronoChlValue      (UINT_  ui_BaseAddress,
						 BYTE_   b_ModulNbr,
						 BYTE_   b_InputChannel,
						 PBYTE_  pb_ChannelStatus);

_INT_   i_APCI1710_KRNL_ReadChronoPortValue     (UINT_  ui_BaseAddress,
						 BYTE_   b_ModulNbr,
						 PBYTE_ pb_PortValue);

/*
+----------------------------------------------------------------------------+
| INP_CPT.C                                                                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitPulseEncoder 	(BYTE_   b_BoardHandle,
					 BYTE_   b_ModulNbr,
					 BYTE_	 b_PulseEncoderNbr,
					 BYTE_	 b_InputLevelSelection,
					 BYTE_	 b_TriggerOutputAction,
					 ULONG_	ul_StartValue);

_INT_	i_APCI1710_EnablePulseEncoder	(BYTE_  b_BoardHandle,
					 BYTE_	b_ModulNbr,
					 BYTE_	b_PulseEncoderNbr,
					 BYTE_	b_CycleSelection,
					 BYTE_	b_InterruptHandling);

_INT_	i_APCI1710_DisablePulseEncoder	(BYTE_  b_BoardHandle,
					 BYTE_	b_ModulNbr,
					 BYTE_	b_PulseEncoderNbr);

/*
+----------------------------------------------------------------------------+
|                       READ PULSE ENCODER FUNCTIONS                         |
+----------------------------------------------------------------------------+
*/

_INT_	i_APCI1710_ReadPulseEncoderStatus	(BYTE_ 	 b_BoardHandle,
						 BYTE_	 b_ModulNbr,
						 BYTE_	 b_PulseEncoderNbr,
						 PBYTE_	pb_Status);


_INT_	i_APCI1710_ReadPulseEncoderValue	(BYTE_	   b_BoardHandle,
						 BYTE_	   b_ModulNbr,
						 BYTE_	   b_PulseEncoderNbr,
						 PULONG_ pul_ReadValue);

/*
+----------------------------------------------------------------------------+
|                       WRITE PULSE ENCODER FUNCTIONS                        |
+----------------------------------------------------------------------------+
*/

_INT_	i_APCI1710_WritePulseEncoderValue	(BYTE_   b_BoardHandle,
						 BYTE_	 b_ModulNbr,
						 BYTE_	 b_PulseEncoderNbr,
						 ULONG_ ul_WriteValue);

_INT_   i_APCI1710_KRNL_ReadPulseEncoderValue   (UINT_    ui_BaseAddress,
						 BYTE_     b_ModulNbr,
						 BYTE_     b_PulseEncoderNbr,
						 PULONG_ pul_ReadValue);

_INT_   i_APCI1710_KRNL_WritePulseEncoderValue  (UINT_  ui_BaseAddress,
						 BYTE_   b_ModulNbr,
						 BYTE_   b_PulseEncoderNbr,
						 ULONG_ ul_WriteValue);

_INT_   i_APCI1710_KRNL_GetInterruptUDLatchedStatus	(UINT_  ui_BaseAddress,
							 BYTE_   b_ModulNbr,
							 PBYTE_ pb_UDStatus);

/*
+----------------------------------------------------------------------------+
| TOR.C                                                                      |
+----------------------------------------------------------------------------+
*/

#define APCI1710_GATE_INPUT 10

#define APCI1710_TOR_SIMPLE_MODE    2
#define APCI1710_TOR_DOUBLE_MODE    3
#define APCI1710_TOR_QUADRUPLE_MODE 4


/*
+----------------------------------------------------------------------------+
|                       TOR_COUNTER INISIALISATION FUNCTION                  |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_InitTorCounter	(BYTE_     b_BoardHandle,
					 BYTE_     b_ModulNbr,
					 BYTE_     b_TorCounter,
					 BYTE_     b_PCIInputClock,
					 BYTE_     b_TimingUnity,
					 ULONG_   ul_TimingInterval,
					 PULONG_ pul_RealTimingInterval);


_INT_   i_APCI1710_EnableTorCounter 	(BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_TorCounter,
					 BYTE_ b_InputMode,
					 BYTE_ b_ExternGate,
					 BYTE_ b_CycleMode,
					 BYTE_ b_InterruptEnable);


_INT_   i_APCI1710_DisableTorCounter    (BYTE_ b_BoardHandle,
					 BYTE_ b_ModulNbr,
					 BYTE_ b_TorCounter);


_INT_   i_APCI1710_GetTorCounterInitialisation (BYTE_     b_BoardHandle,
						BYTE_     b_ModulNbr,
						BYTE_     b_TorCounter,
						PBYTE_   pb_TimingUnity,
						PULONG_ pul_TimingInterval,
						PBYTE_   pb_InputMode,
						PBYTE_   pb_ExternGate,
						PBYTE_   pb_CycleMode,
						PBYTE_   pb_Enable,
						PBYTE_   pb_InterruptEnable);

/*
+----------------------------------------------------------------------------+
|                       TOR_COUNTER READ FUNCTION                            |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_GetTorCounterProgressStatus  (BYTE_    b_BoardHandle,
						 BYTE_    b_ModulNbr,
						 BYTE_    b_TorCounter,
						 PBYTE_  pb_TorCounterStatus);

_INT_   i_APCI1710_ReadTorCounterValue      	(BYTE_     b_BoardHandle,
						 BYTE_     b_ModulNbr,
						 BYTE_    b_TorCounter,
						 UINT_    ui_TimeOut,
						 PBYTE_   pb_TorCounterStatus,
						 PULONG_ pul_TorCounterValue);



/*
+----------------------------------------------------------------------------+
|                       TOR_COUNTER KRNL FUNCTION                            |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_KRNL_GetTorCounterProgressStatus      (UINT_   ui_BaseAddress,
							  BYTE_    b_ModulNbr,
							  BYTE_    b_TorCounter,
							  PBYTE_  pb_TorCounterStatus);

_INT_   i_APCI1710_KRNL_ReadTorCounterValue      (UINT_    ui_BaseAddress,
						  BYTE_     b_ModulNbr,
						  BYTE_     b_TorCounter,
						  PBYTE_   pb_TorCounterStatus,
						  PULONG_ pul_TorCounterValue);


/*
+----------------------------------------------------------------------------+
| PWM.C                                                                      |
+----------------------------------------------------------------------------+
*/

/*
+----------------------------------------------------------------------------+
|                       PWM INISIALISATION FUNCTION                          |
+----------------------------------------------------------------------------+
*/

_INT_	i_APCI1710_InitPWM	(BYTE_	   b_BoardHandle,
				 BYTE_	   b_ModulNbr,
				 BYTE_	   b_PWM,
				 BYTE_	   b_ClockSelection,
				 BYTE_	   b_TimingUnit,
				 ULONG_	  ul_LowTiming,
				 ULONG_   ul_HighTiming,
				 PULONG_ pul_RealLowTiming,
				 PULONG_ pul_RealHighTiming);

_INT_   i_APCI1710_SetNewPWMTiming	(BYTE_     b_BoardHandle,
					 BYTE_     b_ModulNbr,
					 BYTE_     b_PWM,
					 BYTE_     b_TimingUnit,
					 ULONG_   ul_LowTiming,
					 ULONG_   ul_HighTiming);

_INT_	i_APCI1710_EnablePWM	(BYTE_  b_BoardHandle,
				 BYTE_  b_ModulNbr,
				 BYTE_  b_PWM,
				 BYTE_  b_StartLevel,
				 BYTE_  b_StopMode,
				 BYTE_  b_StopLevel,
				 BYTE_  b_ExternGate,
				 BYTE_  b_InterruptEnable);

_INT_	i_APCI1710_DisablePWM	(BYTE_  b_BoardHandle,
				 BYTE_  b_ModulNbr,
				 BYTE_  b_PWM);

_INT_	i_APCI1710_GetPWMInitialisation	(BYTE_	   b_BoardHandle,
					 BYTE_	   b_ModulNbr,
					 BYTE_	   b_PWM,
					 PBYTE_	  pb_TimingUnit,
					 PULONG_ pul_LowTiming,
					 PULONG_ pul_HighTiming,
					 PBYTE_	  pb_StartLevel,
					 PBYTE_	  pb_StopMode,
					 PBYTE_	  pb_StopLevel,
					 PBYTE_	  pb_ExternGate,
					 PBYTE_	  pb_InterruptEnable,
					 PBYTE_	  pb_Enable);

/*
+----------------------------------------------------------------------------+
|                       PWM STATUS FUNCTION                                  |
+----------------------------------------------------------------------------+
*/

_INT_ 	i_APCI1710_GetPWMStatus	(BYTE_	  b_BoardHandle,
				 BYTE_	  b_ModulNbr,
				 BYTE_	  b_PWM,
				 PBYTE_	 pb_PWMOutputStatus,
				 PBYTE_	 pb_ExternGateStatus);

_INT_	i_APCI1710_KRNL_GetPWMStatus  (UINT_	 ui_BaseAddress,
				       BYTE_	  b_ModulNbr,
				       BYTE_	  b_PWM,
				       PBYTE_	 pb_PWMOutputStatus,
				       PBYTE_	 pb_ExternGateStatus);

_INT_   i_APCI1710_KRNL_SetNewPWMTiming	     (UINT_    ui_BaseAddress,
					      BYTE_     b_ModulNbr,
					      BYTE_     b_PWM,
					      BYTE_     b_ClockSelection,
					      BYTE_     b_TimingUnit,
					      ULONG_   ul_LowTiming,
					      ULONG_   ul_HighTiming);


/*
+----------------------------------------------------------------------------+
| ETM.C                                                                      |
+----------------------------------------------------------------------------+
*/

/*
+----------------------------------------------------------------------------+
|                       ETM INISIALISATION FUNCTION                          |
+----------------------------------------------------------------------------+
*/


_INT_	i_APCI1710_InitETM	(BYTE_     b_BoardHandle,
				 BYTE_     b_ModulNbr,
				 BYTE_     b_ClockSelection,
				 BYTE_     b_TimingUnit,
				 ULONG_   ul_Timing,
				 PULONG_ pul_RealTiming);

_INT_	i_APCI1710_EnableETM	(BYTE_		 b_BoardHandle,
				 BYTE_		 b_ModulNbr,
				 BYTE_		 b_ETM,
				 BYTE_		 b_EdgeLevel,
				 BYTE_		 b_TriggerLevel,
				 BYTE_		 b_CycleMode,
				 BYTE_		 b_FirstTriggerMode,
				 BYTE_		 b_InterruptEnable);

_INT_	i_APCI1710_DisableETM	(BYTE_  b_BoardHandle,
				 BYTE_  b_ModulNbr,
				 BYTE_  b_ETM);

_INT_	i_APCI1710_GetETMInitialisation	(BYTE_	   b_BoardHandle,
					 BYTE_	   b_ModulNbr,
					 BYTE_	   b_ETM,
					 PBYTE_	  pb_TimingUnit,
					 PULONG_ pul_Timing,
					 PBYTE_	  pb_EdgeLevel,
					 PBYTE_	  pb_TriggerLevel,
					 PBYTE_	  pb_CycleMode,
					 PBYTE_	  pb_FirstTriggerMode,
					 PBYTE_	  pb_InterruptEnable,
					 PBYTE_	  pb_Enable);

/*
+----------------------------------------------------------------------------+
|                       ETM STATUS FUNCTION                                  |
+----------------------------------------------------------------------------+
*/

_INT_	i_APCI1710_GetETMProgressStatus	(BYTE_	  b_BoardHandle,
					 BYTE_    b_ModulNbr,
					 BYTE_	  b_ETM,
					 PBYTE_	 pb_ETMtatus);

_INT_	i_APCI1710_ReadETMValue	(BYTE_	   b_BoardHandle,
				 BYTE_	   b_ModulNbr,
				 BYTE_	   b_ETM,
				 UINT_	  ui_TimeOut,
				 PBYTE_	  pb_ETMtatus,
				 PULONG_ pul_ETMValue);

_INT_	i_APCI1710_ConvertETMValue	(BYTE_	   b_BoardHandle,
					 BYTE_	   b_ModulNbr,
					 ULONG_	  ul_ETMValue,
					 PULONG_ pul_Hour,
					 PBYTE_	  pb_Minute,
					 PBYTE_	  pb_Second,
					 PUINT_	 pui_MilliSecond,
					 PUINT_	 pui_MicroSecond,
					 PUINT_	 pui_NanoSecond);

_INT_	i_APCI1710_ReadETMTotalTime	(BYTE_	   b_BoardHandle,
					 BYTE_	   b_ModulNbr,
					 BYTE_	   b_ETM,
					 UINT_	  ui_TimeOut,
					 PBYTE_	  pb_ETMtatus,
					 PULONG_ pul_ETMValue);

_INT_	i_APCI1710_KRNL_ReadETMTotalTime (UINT_    ui_BaseAddress,
					 BYTE_	   b_ModulNbr,
					 BYTE_	   b_ETM,
					 PULONG_ pul_ETMValue);

_INT_   i_APCI1710_KRNL_ReadETMValue (UINT_    ui_BaseAddress,
				      BYTE_	   b_ModulNbr,
				      BYTE_	   b_ETM,
				      PULONG_ pul_ETMValue);

/*
+----------------------------------------------------------------------------+
| CDA.C                                                                      |
+----------------------------------------------------------------------------+
*/

/*
+----------------------------------------------------------------------------+
|                       CDA INISIALISATION FUNCTION                          |
+----------------------------------------------------------------------------+
*/

_INT_   i_APCI1710_SetCDAFunctionality	(BYTE_	b_BoardHandle,
					 BYTE_	b_ModulNbr,
					 BYTE_	b_FunctionalitySelection);

_INT_	i_APCI1710_InitCDA  		(BYTE_	 b_BoardHandle,
					 BYTE_	 b_ModulNbr,
					 ULONG_	ul_Step,
					 ULONG_	ul_Multiplier);

_INT_	i_APCI1710_EnableCDA		(BYTE_	 b_BoardHandle,
					 BYTE_	 b_ModulNbr);

_INT_	i_APCI1710_DisableCDA		(BYTE_	 b_BoardHandle,
					 BYTE_	 b_ModulNbr);

/*
+----------------------------------------------------------------------------+
|                       CDA STATUS FUNCTION                                  |
+----------------------------------------------------------------------------+
*/

_INT_	i_APCI1710_GetCDAProgressStatus		(BYTE_	  b_BoardHandle,
						 BYTE_	  b_ModulNbr,
						 PBYTE_	 pb_CDAStatus,
						 PBYTE_	 pb_FIFOStatus,
						 PBYTE_	 pb_Overflow);

_INT_	i_APCI1710_ReadCDAMinAndMaxDifference	(BYTE_	  b_BoardHandle,
						 BYTE_	  b_ModulNbr,
						 PLONG_	 pl_MinDifference,
						 PLONG_	 pl_MaxDifference);

_INT_	i_APCI1710_ReadCDAArrayFromFIFO		(BYTE_	  b_BoardHandle,
						 BYTE_	  b_ModulNbr,
						 ULONG_	 ul_NumberOfElement,
						 PLONG_	 pl_DifferenceArray);

_INT_	i_APCI1710_KRNL_ReadCDAArrayFromFIFO	(UINT_    ui_BaseAddress,
						 BYTE_	   b_ModulNbr,
						 ULONG_	  ul_NumberOfElement,
						 PLONG_	  pl_DifferenceArray,
						 PBYTE_	  pb_Overflow,
						 PULONG_ pul_ReadNumberOfElement);

_INT_	i_APCI1710_KRNL_DisableCDA		(UINT_ ui_BaseAddress,
						 BYTE_	 b_ModulNbr);






/*
+----------------------------------------------------------------------------+
|                       SSI Monitor INISIALISATION FUNCTION                  |
+----------------------------------------------------------------------------+
*/

_INT_ i_APCI1710_InitSSIMonitor(	BYTE_	b_BoardHandle,
											BYTE_	b_ModulNbr,
											BYTE_	b_SSIBitNbr_in);			

_INT_ i_APCI1710_InitSSIMonitorInterruptData(	BYTE_	b_BoardHandle,
																BYTE_	b_ModulNbr,
																BYTE_	b_SSIInterrupt_Data);

_INT_ i_APCI1710_InitSSIMonitorInterruptError(	   BYTE_	b_BoardHandle,
																	BYTE_	b_ModulNbr,
																	BYTE_	b_SSIInterrupt_Error,
																	BYTE_ b_SSIInterrupt_ErrorOutput_5V,
																	BYTE_	b_extBitNbr_in,
																	BYTE_	b_SSIDelayTime_min_in);													

_INT_ i_APCI1710_InitSSIMonitorTriggerOutput(	BYTE_	b_BoardHandle,
																BYTE_	b_ModulNbr,
																BYTE_	b_SSITriggerOutput);

_INT_ i_APCI1710_InitSSIMonitorExternalGate(	BYTE_	b_BoardHandle,
															BYTE_	b_ModulNbr,
															BYTE_	b_SSIExternalGate,
															BYTE_	b_SSIExternalGateNbr);

_INT_ i_APCI1710_StartSSIMonitor(	BYTE_	b_BoardHandle,
												BYTE_	b_ModulNbr);

_INT_ i_APCI1710_StopSSIMonitor(	BYTE_	b_BoardHandle,
											BYTE_	b_ModulNbr);

_INT_ i_APCI1710_ResetSSIMonitorFIFO(	BYTE_	b_BoardHandle,
													BYTE_	b_ModulNbr);

_INT_ i_APCI1710_SetSSIMonitorDigitalOutputON(	BYTE_	b_BoardHandle,
																BYTE_	b_ModulNbr,
																BYTE_	b_SSIDigitalOutputNbr);
									
_INT_ i_APCI1710_SetSSIMonitorDigitalOutputOFF(	BYTE_	b_BoardHandle,
																BYTE_	b_ModulNbr,
																BYTE_	b_SSIDigitalOutputNbr);

_INT_ i_APCI1710_ReadSSIMonitorMeasuringStatus(	BYTE_	b_BoardHandle,
																BYTE_	b_ModulNbr,
																PBYTE_	pb_SSIMeasuring_ON,
																PBYTE_	pb_SSIEndSearch_MonoTime,
																PBYTE_	pb_SSIEndSearch_DelayTime,
																PBYTE_	pb_SSIEndSearch_Frequency);
												
_INT_ i_APCI1710_ReadSSIMonitorFIFOStatus(	BYTE_	b_BoardHandle,
															BYTE_	b_ModulNbr,
															PBYTE_	pb_SSIFIFO_newValue,
															PBYTE_	pb_SSIFIFO_nempty,
															PBYTE_	pb_SSIFIFO_hfull,
															PBYTE_	pb_SSIFIFO_full,
															PULONG_	pul_SSIFIFO_value);

_INT_ i_APCI1710_ReadSSIMonitorAllDigitalInputs(	BYTE_	b_BoardHandle,
																	BYTE_	b_ModulNbr,
																	PBYTE_	pb_SSIInput_Status);

_INT_ i_APCI1710_CheckSSIMonitor40MHzStatus(	BYTE_	b_BoardHandle,
															BYTE_	b_ModulNbr,
															PBYTE_	pb_SSI40MHz_Status);

_INT_ i_APCI1710_ReadSSIMonitorMonoTime(	BYTE_	b_BoardHandle,
														BYTE_	b_ModulNbr,
														double	*pd_SSIMonoTime_out);

_INT_ i_APCI1710_ReadSSIMonitorDelayTime(	BYTE_	b_BoardHandle,
														BYTE_	b_ModulNbr,
														double	*pd_SSIDelayTime_out);

_INT_ i_APCI1710_ReadSSIMonitorFrequency(	BYTE_	b_BoardHandle,
														BYTE_	b_ModulNbr,
														double	*pd_SSIFrequency_out);

_INT_ i_APCI1710_ReadSSIMonitorData(	BYTE_	b_BoardHandle,
													BYTE_	b_ModulNbr,
													PULONG_	pul_SSIData_out);

_INT_ i_APCI1710_ReadSSIMonitorErrorInterruptStatus(	BYTE_	   b_BoardHandle,
																		BYTE_	   b_ModulNbr,
																		PBYTE_	pb_SSIError_Register,
																		PULONG_	pul_SSIFIFO_errvalue,
																		double	*pd_SSIDelayTime_out);

_INT_ i_APCI1710_ReadSSIMonitorRestFIFOData(	BYTE_	b_BoardHandle,
														   BYTE_	b_ModulNbr,
														   PULONG_	pul_RestData_out,
														   PBYTE_	pb_UsefulRestBit);


#endif



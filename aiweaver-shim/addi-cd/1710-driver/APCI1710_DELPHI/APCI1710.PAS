UNIT APCI1710;

INTERFACE

Type
  PPointer = ^Pointer;


CONST
   DLL_COMPILER_C             : BYTE = $0;
   DLL_COMPILER_PASCAL        : BYTE = $1;
   DLL_COMPILER_VB            : BYTE = $2;
   DLL_LABVIEW                : BYTE = $3;
   DLL_COMPILER_VB_5          : BYTE = $4;
   APCI1710_DISABLE           : BYTE = $0;
   APCI1710_ENABLE            : BYTE = $1;
   APCI1710_16BIT_COUNTER     : BYTE = $10;
   APCI1710_32BIT_COUNTER     : BYTE = $0;
   APCI1710_QUADRUPLE_MODE    : BYTE = $0;
   APCI1710_DOUBLE_MODE       : BYTE = $3;
   APCI1710_SIMPLE_MODE       : BYTE = $F;
   APCI1710_DIRECT_MODE       : BYTE = $80;
   APCI1710_HYSTERESIS_ON     : BYTE = $60;
   APCI1710_HYSTERESIS_OFF    : BYTE = $0;
   APCI1710_INCREMENT         : BYTE = $60;
   APCI1710_DECREMENT         : BYTE = $0;
   APCI1710_LATCH_COUNTER     : BYTE = $1;
   APCI1710_CLEAR_COUNTER     : BYTE = $0;
   APCI1710_LOW               : BYTE = $0;
   APCI1710_HIGH              : BYTE = $1;

   APCI1710_HIGH_EDGE_CLEAR_COUNTER             : BYTE = $0;
   APCI1710_HIGH_EDGE_LATCH_COUNTER             : BYTE = $1;
   APCI1710_LOW_EDGE_CLEAR_COUNTER              : BYTE = $2;
   APCI1710_LOW_EDGE_LATCH_COUNTER              : BYTE = $3;
   APCI1710_HIGH_EDGE_LATCH_AND_CLEAR_COUNTER   : BYTE = $4;
   APCI1710_LOW_EDGE_LATCH_AND_CLEAR_COUNTER    : BYTE = $5;
   APCI1710_SOURCE_0                            : BYTE = $0;
   APCI1710_SOURCE_1                            : BYTE = $1;

   APCI1710_SYNCHRONOUS_MODE  : BYTE = $1;
   APCI1710_ASYNCHRONOUS_MODE : BYTE = $0;


   APCI1710_30MHZ             : BYTE = 30;
   APCI1710_33MHZ             : BYTE = 33;
   APCI1710_40MHZ             : BYTE = 40;
   APCI1710_10MHZ             : BYTE = 10;
   APCI1710_BINARY_MODE       : BYTE = $1;
   APCI1710_GRAY_MODE         : BYTE = $0;

   APCI1710_PCI_BUS_CLOCK         : BYTE = 0;
   APCI1710_FRONT_CONNECTOR_INPUT : BYTE = 1;

   APCI1710_SINGLE     : BYTE = 0;
   APCI1710_CONTINUOUS : BYTE = 1;

{****************************************************************************}
{*   APCI1710.C                                                             *}
{****************************************************************************}

Function   i_APCI1710_InitCompiler              (b_CompilerDefine : Byte):Integer;Far;StdCall;

Function   i_APCI1710_CheckAndGetPCISlotNumber  (VAR pb_SlotNumberArray : Byte):Integer;Far;StdCall;

Function   i_APCI1710_SetBoardInformation       (    b_SlotNumber   : Byte;
						 Var pb_BoardHandle : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetHardwareInformation    (      b_BoardHandle  : Byte;
						 VAR  l_BaseAddress : LongInt;
						 Var  pb_InterruptNbr : Byte;
						 Var  pb_SlotNumber   : Byte):Integer;Far;StdCall;

Function   i_APCI1710_CloseBoardHandle          (b_BoardHandle : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadRegister (b_BoardHandle : Byte;
                                    b_ModulNbr : Byte;
                                    b_SelectedRegister : Byte;
                                    var dw_ReadValue : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_WriteRegister (b_BoardHandle : Byte;
                                     b_ModulNbr : Byte;
                                     b_SelectedRegister : Byte;
                                     dw_WriteValue : LongInt):Integer;Far;StdCall;


{****************************************************************************}
{*   1710INT.C                                                              *}
{****************************************************************************}

Function   i_APCI1710_SetBoardIntRoutineWin32     (b_BoardHandle        : Byte;
						   b_UserCallingMode    : Byte;
						   ul_GlobalBufferSize  : LongInt;
						   ppv_UserGloablBuffer : PPointer;
						   v_FunctionName       : Pointer):Integer;Far;StdCall;

Function   i_APCI1710_TestInterrupt             (Var  pb_BoardHandle       : Byte;
						 Var  pb_ModuleMask        : Byte;
						 Var pul_InterruptMask     : LongInt;
						 Var pul_CounterLatchValue : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_ResetBoardIntRoutine      (b_BoardHandle : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetSharedMemoryPointer      (b_BoardHandle        : Byte;
						  ppv_SharedMemoryRing3Pointer : PPointer;
						  ppv_SharedMemoryRing0Pointer : PPointer):Integer;Far;StdCall;

{****************************************************************************}
{*   INC_CPT.C                                                              *}
{****************************************************************************}

Function   i_APCI1710_InitCounter               (b_BoardHandle         : Byte;
						 b_ModulNbr            : Byte;
						 b_CounterRange        : Byte;
						 b_FirstCounterModus   : Byte;
						 b_FirstCounterOption  : Byte;
						 b_SecondCounterModus  : Byte;
						 b_SecondCounterOption : Byte):Integer;Far;StdCall;

Function   i_APCI1710_CounterAutoTest           (     b_BoardHandle : Byte;
						 Var pb_TestStatus  : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ClearCounterValue         (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ClearAllCounterValue      (b_BoardHandle : Byte):Integer;Far;StdCall;

Function   i_APCI1710_SetInputFilter            (b_BoardHandle   : Byte;
						 b_ModulNbr      : Byte;
						 b_PCIInputClock : Byte;
						 b_Filter        : Byte):Integer;Far;StdCall;


{****************************************************************************}
{*                       READ COUNTER FunctionS                             *}
{****************************************************************************}

Function   i_APCI1710_LatchCounter              (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte;
						 b_LatchReg    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadLatchRegisterStatus   (     b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						      b_LatchReg    : Byte;
						 Var pb_LatchStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadLatchRegisterValue    (      b_BoardHandle : Byte;
						       b_ModulNbr    : Byte;
						       b_LatchReg    : Byte;
						 Var pul_LatchValue  : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_EnableLatchInterrupt      (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_DisableLatchInterrupt     (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_Read16BitCounterValue     (b_BoardHandle        : Byte;
						 b_ModulNbr           : Byte;
						 b_SelectedCounter    : Byte;
						 Var pl_CounterValue  : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_Read32BitCounterValue     (      b_BoardHandle  : Byte;
						       b_ModulNbr     : Byte;
						 Var pul_CounterValue : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{*                       WRITE COUNTER FunctionS                            *}
{****************************************************************************}


Function   i_APCI1710_Write16BitCounterValue    (b_BoardHandle     : Byte;
						 b_ModulNbr        : Byte;
						 b_SelectedCounter : Byte;
						 w_WriteValue      : Word):Integer;Far;StdCall;

Function   i_APCI1710_Write32BitCounterValue    (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte;
						 ul_WriteValue : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{*                          INDEX FunctionS                                 *}
{****************************************************************************}


Function   i_APCI1710_InitIndex         (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_ReferenceAction : Byte;
					 b_IndexOperation  : Byte;
					 b_AutoMode        : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;

Function   i_APCI1710_EnableIndex       (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_DisableIndex      (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetIndexStatus    (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_IndexStatus : Byte):Integer;Far;StdCall;

Function  i_APCI1710_SetIndexAndReferenceSource (b_BoardHandle     : Byte;
						 b_ModulNbr        : Byte;
						 b_SourceSelection : Byte):Integer;Far;StdCall;


{****************************************************************************}
{*                            REFERENCE FunctionS                           *}
{****************************************************************************}

Function   i_APCI1710_InitReference     (b_BoardHandle    : Byte;
					 b_ModulNbr       : Byte;
					 b_ReferenceLevel : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetReferenceStatus (    b_BoardHandle     : Byte;
					      b_ModulNbr        : Byte;
					 Var pb_ReferenceStatus : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                            UAS;CBx;U/D# FunctionS                        *}
{****************************************************************************}

Function   i_APCI1710_GetUASStatus      (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_UASStatus   : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetCBStatus       (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_CBStatus    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_Get16BitCBStatus	(     b_BoardHandle      : Byte;
					      b_ModulNbr         : Byte;
					 Var pb_CBStatusCounter0 : Byte;
					 Var pb_CBStatusCounter1 : Byte):Integer;Far;StdCall;


Function   i_APCI1710_GetUDStatus       (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_UDStatus    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetInterruptUDLatchedStatus       (     b_BoardHandle : Byte;
							      b_ModulNbr    : Byte;
							 Var pb_UDStatus    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_InitExternalStrobe                (b_BoardHandle         : Byte;
							 b_ModulNbr            : Byte;
							 b_ExternalStrobe      : Byte;
							 b_ExternalStrobeLevel : Byte):Integer;Far;StdCall;


(****************************************************************************)
(*                           Compare FunctionS                              *)
(****************************************************************************)

Function        i_APCI1710_InitCompareLogic    ( b_BoardHandle  : Byte;
						 b_ModulNbr     : Byte;
						ui_CompareValue : Longint):Integer;Far;StdCall;

Function        i_APCI1710_EnableCompareLogic  (b_BoardHandle   : Byte;
						b_ModulNbr      : Byte):Integer;Far;StdCall;

Function        i_APCI1710_DisableCompareLogic (b_BoardHandle   : Byte;
						b_ModulNbr      : Byte):Integer;Far;StdCall;

(****************************************************************************)
(*                 Frequency measurement FunctionS                          *)
(****************************************************************************)


Function   i_APCI1710_InitFrequencyMeasurement    (      b_BoardHandle        : Byte;
							 b_ModulNbr           : Byte;
							 b_PCIInputClock      : Byte;
							 b_TimingUnity        : Byte;
							ul_TimingInterval     : LongInt;
						   Var pul_RealTimingInterval : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_EnableFrequencyMeasurement  (b_BoardHandle     : Byte;
						   b_ModulNbr        : Byte;
						   b_InterruptEnable : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadFrequencyMeasurement    (      b_BoardHandle : Byte;
							 b_ModulNbr    : Byte;
						   Var  pb_Status      : Byte;
						   Var  pb_UDStatus    : Byte;
						   Var pul_ReadValue   : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_DisableFrequencyMeasurement (b_BoardHandle : Byte;
						   b_ModulNbr    : Byte):Integer;Far;StdCall;


{****************************************************************************}
{*                     Digital output FUNCTIONS                             *}
{****************************************************************************}

Function   i_APCI1710_SetDigitalChlOn           (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_SetDigitalChlOff          (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;


{****************************************************************************}
{*                     Inc. Counter KRNL Function                           *}
{****************************************************************************}

Function   i_APCI1710_KRNL_ClearCounterValue       (ui_BaseAddress : Word;
						     b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadLatchRegisterValue   (    ui_BaseAddress   : Word;
							  b_ModulNbr      : Byte;
							  b_LatchReg      : Byte;
						    Var pul_LatchValue    : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_Read16BitCounterValue   (     ui_BaseAddress     : Word;
							  b_ModulNbr        : Byte;
							  b_SelectedCounter : Byte;
						    Var pui_CounterValue    : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_Read32BitCounterValue   (     ui_BaseAddress  : Word;
							  b_ModulNbr     : Byte;
						    Var pul_CounterValue : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_Write16BitCounterValue  (ui_BaseAddress     : Word;
						     b_ModulNbr        : Byte;
						     b_SelectedCounter : Byte;
						    ui_WriteValue      : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_Write32BitCounterValue  (ui_BaseAddress : Word;
						     b_ModulNbr    : Byte;
						    ul_WriteValue  : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_GetInterruptUDLatchedStatus  (    ui_BaseAddress : Word;
							      b_ModulNbr    : Byte;
							 Var pb_UDStatus    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadFrequencyMeasurement     (     ui_BaseAddress : Word;
							       b_ModulNbr    : Byte;
							 Var  pb_Status      : Byte;
							 Var  pb_UDStatus    : Byte;
							 Var pul_ReadValue   : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_SetDigitalChlOn              (ui_BaseAddress : Word;
							  b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_SetDigitalChlOff             (ui_BaseAddress : Word;
							  b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_InitCompareLogic             (ui_BaseAddress  : Word;
							  b_ModulNbr     : Byte;
							 ui_CompareValue : Longint):Integer;Far;StdCall;


{****************************************************************************}
{*   SCSI.C                                                                 *}
{****************************************************************************}

Function   i_APCI1710_InitSSI           ( b_BoardHandle        : Byte;
					  b_ModulNbr           : Byte;
					  b_SSIProfile         : Byte;
					  b_PositionTurnLength : Byte;
					  b_TurnCptLength      : Byte;
					  b_PCIInputClock      : Byte;
					 ul_SSIOutputClock     : LongInt;
					  b_SSICountingMode    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_Read1SSIValue     (      b_BoardHandle : BYte;
					       b_ModulNbr    : Byte;
					       b_SelectedSSI : Byte;
					 Var pul_Position    : LongInt;
					 Var pul_TurnCpt     : LongInt):Integer;Far;StdCall;


Function   i_APCI1710_ReadAllSSIValue   (      b_BoardHandle : Byte;
					       b_ModulNbr    : Byte;
					 Var pul_Position    : LongInt;
					 Var pul_TurnCpt     : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{*                     SSI DIGITAL INPUT Function                           *}
{****************************************************************************}

Function   i_APCI1710_ReadSSI1DigitalInput   (     b_BoardHandle   : Byte;
						   b_ModulNbr      : Byte;
						   b_InputChannel  : Byte;
					      Var pb_ChannelStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadSSIAllDigitalInput (     b_BoardHandle : Byte;
						   b_ModulNbr    : Byte;
					      Var pb_InputStatus : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                     SSI DIGITAL OUTPUT Function                          *}
{****************************************************************************}

Function   i_APCI1710_SetSSIDigitalOutputOn  (b_BoardHandle : Byte;
					      b_ModulNbr    : Byte):Integer;Far;StdCall;

Function   i_APCI1710_SetSSIDigitalOutputOff (b_BoardHandle : Byte;
					      b_ModulNbr    : Byte):Integer;Far;StdCall;

{******************************************************************************}
{*                            SSI KRNL FUNCTIONS                              *}
{******************************************************************************}

Function   i_APCI1710_KRNL_ReadSSI1DigitalInput   (   ui_BaseAddress   : Word;
						       b_ModulNbr      : Byte;
						       b_InputChannel  : Byte;
						   Var b_ChannelStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadSSIAllDigitalInput (   ui_BaseAddress : Word;
						       b_ModulNbr    : Byte;
						   Var b_InputStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_SetSSIDigitalOutputOn  (ui_BaseAddress : Word;
						    b_ModulNbr     : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_SetSSIDigitalOutputOff (ui_BaseAddress : Word;
						    b_ModulNbr    : Byte):Integer;Far;StdCall;


{******************************************************************************}
{*   TTL.C                                                                    *}
{******************************************************************************}

Function        i_APCI1710_InitTTLIO                 (b_BoardHandle : Byte;
						      b_ModulNbr    : Byte):Integer;Far;StdCall;

Function        i_APCI1710_InitTTLIODirection	     (b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						      b_PortAMode   : Byte;
						      b_PortBMode   : Byte;
						      b_PortCMode   : Byte;
						      b_PortDMode   : Byte):Integer;Far;StdCall;

Function        i_APCI1710_ReadTTLIOChannelValue     (     b_BoardHandle   : Byte;
							   b_ModulNbr      : Byte;
							   b_SelectedPort  : Byte;
							   b_InputChannel  : Byte;
						      Var pb_ChannelStatus : Byte):Integer;Far;StdCall;

Function        i_APCI1710_ReadTTLIOPortValue        (    b_BoardHandle  : Byte;
							  b_ModulNbr     : Byte;
							  b_SelectedPort : Byte;
						      Var pb_PortValue   : Byte):Integer;Far;StdCall;

Function        i_APCI1710_ReadTTLIOAllPortValue     (      b_BoardHandle : Byte;
							    b_ModulNbr    : Byte;
						      Var pul_PortValue   : LongInt):Integer;Far;StdCall;

(*
+----------------------------------------------------------------------------+
|                       TTL DIGITAL OUTPUT Function                          |
+----------------------------------------------------------------------------+
*)

Function        i_APCI1710_SetTTLIOChlOn        (b_BoardHandle   : Byte;
						 b_ModulNbr      : Byte;
						 b_OutputChannel : Byte):Integer;Far;StdCall;

Function        i_APCI1710_SetTTLIOChlOff       (b_BoardHandle   : Byte;
						 b_ModulNbr      : Byte;
						 b_OutputChannel : Byte):Integer;Far;StdCall;



{******************************************************************************}
{*                            TTL KRNL FUNCTIONS                              *}
{******************************************************************************}

Function        i_APCI1710_KRNL_ReadTTLIOChannelValue  (  ui_BaseAddress     : Word;
							   b_ModulNbr        : Byte;
							   b_SelectedPort    : Byte;
							   b_InputChannel    : Byte;
							Var pb_ChannelStatus : Byte):Integer;Far;StdCall;

Function        i_APCI1710_KRNL_ReadTTLIOPortValue     (    ui_BaseAddress  : Word;
							     b_ModulNbr     : Byte;
							     b_SelectedPort : Byte;
							Var pb_PortValue    : Byte):Integer;Far;StdCall;


Function        i_APCI1710_KRNL_ReadTTLIOAllPortValue  (     ui_BaseAddress : Word;
							      b_ModulNbr    : Byte;
							Var pul_PortValue   : LongInt):Integer;Far;StdCall;

Function        i_APCI1710_KRNL_SetTTLIOChlOn           (ui_BaseAddress  : Word;
							 b_ModulNbr      : Byte;
							 b_OutputChannel : Byte):Integer;Far;StdCall;

Function        i_APCI1710_KRNL_SetTTLIOChlOff          (ui_BaseAddress  : Word;
							 b_ModulNbr      : Byte;
							 b_OutputChannel : Byte):Integer;Far;StdCall;


{******************************************************************************}
{*   DIG_IO.C                                                                 *}
{******************************************************************************}

Function        i_APCI1710_InitDigitalIO               (b_BoardHandle  : Byte;
							b_ModulNbr     : Byte;
							b_ChannelAMode : Byte;
							b_ChannelBMode : Byte):Integer;Far;StdCall;

Function        i_APCI1710_ReadDigitalIOChlValue       (     b_BoardHandle   : Byte;
							     b_ModulNbr      : Byte;
							     b_InputChannel  : Byte;
							Var pb_ChannelStatus : Byte):Integer;Far;StdCall;

Function        i_APCI1710_ReadDigitalIOPortValue      (     b_BoardHandle : Byte;
							     b_ModulNbr    : Byte;
							Var pb_PortValue   : Byte):Integer;Far;StdCall;

Function        i_APCI1710_SetDigitalIOMemoryOn        (b_BoardHandle : Byte;
							b_ModulNbr    : Byte):Integer;Far;StdCall;

Function        i_APCI1710_SetDigitalIOMemoryOff       (b_BoardHandle : Byte;
							b_ModulNbr    : Byte):Integer;Far;StdCall;

Function        i_APCI1710_SetDigitalIOChlOn           (b_BoardHandle   : Byte;
							b_ModulNbr      : Byte;
							b_OutputChannel : Byte):Integer;Far;StdCall;

Function        i_APCI1710_SetDigitalIOChlOff          (b_BoardHandle   : Byte;
							b_ModulNbr      : Byte;
							b_OutputChannel : Byte):Integer;Far;StdCall;

Function        i_APCI1710_SetDigitalIOPortOn          (b_BoardHandle : Byte;
							b_ModulNbr    : Byte;
							b_PortValue   : Byte):Integer;Far;StdCall;

Function        i_APCI1710_SetDigitalIOPortOff         (b_BoardHandle : Byte;
							b_ModulNbr    : Byte;
							b_PortValue   : Byte):Integer;Far;StdCall;

{******************************************************************************}
{*                            KRNL FUNCTIONS                                  *}
{******************************************************************************}

{******************************************************************************}
{*                          INPUT FUNCTIONS                                   *}
{******************************************************************************}

Function        i_APCI1710_KRNL_ReadDigitalIOChlValue      (    ui_BaseAddress   : Word;
								 b_ModulNbr      : Byte;
								 b_InputChannel  : Byte;
							    Var pb_ChannelStatus : Byte):Integer;Far;StdCall;

Function        i_APCI1710_KRNL_ReadDigitalIOPortValue     (   ui_BaseAddress : Word;
								b_ModulNbr    : Byte;
							    Var pb_PortValue  : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                          OUTPUT FUNCTIONS                                *}
{****************************************************************************}

Function        i_APCI1710_KRNL_SetDigitalIOChlOn            (ui_BaseAddress   : Word;
							       b_ModulNbr      : Byte;
							       b_OutputChannel : Byte):Integer;Far;StdCall;

Function        i_APCI1710_KRNL_SetDigitalIOPortOn           (ui_BaseAddress : Word;
							       b_ModulNbr    : Byte;
							       b_PortValue   : Byte):Integer;Far;StdCall;

{******************************************************************************}
{*   82X54.C                                                                  *}
{******************************************************************************}

{****************************************************************************}
{*                     82X54 TIMER INISIALISATION FUNCTION                  *}
{****************************************************************************}


Function        i_APCI1710_InitTimer    (b_BoardHandle         : Byte;
					 b_ModulNbr            : Byte;
					 b_TimerNbr            : Byte;
					 b_TimerMode           : Byte;
					 ul_ReloadValue        : LongInt;
					 b_InputClockSelection : Byte;
					 b_InputClockLevel     : Byte;
					 b_OutputLevel         : Byte;
					 b_HardwareGateLevel   : Byte):Integer;Far;StdCall;

Function        i_APCI1710_EnableTimer  (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_TimerNbr        : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;

Function        i_APCI1710_DisableTimer (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte;
					 b_TimerNbr    : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                       82X54 READ FUNCTION                                *}
{****************************************************************************}

Function        i_APCI1710_ReadTimerValue               (      b_BoardHandle : Byte;
							       b_ModulNbr    : Byte;
							       b_TimerNbr    : Byte;
							 Var pul_TimerValue  : LongInt):Integer;Far;StdCall;

Function        i_APCI1710_ReadAllTimerValue            (      b_BoardHandle     : Byte;
							       b_ModulNbr        : Byte;
							 Var pul_TimerValueArray : LongInt):Integer;Far;StdCall;

Function        i_APCI1710_GetTimerOutputLevel          (     b_BoardHandle : Byte;
							      b_ModulNbr    : Byte;
							      b_TimerNbr    : Byte;
							 Var pb_OutputLevel : Byte):Integer;Far;StdCall;

Function        i_APCI1710_GetTimerProgressStatus       (     b_BoardHandle : Byte;
							      b_ModulNbr    : Byte;
							      b_TimerNbr    : Byte;
							 Var pb_TimerStatus : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                    82X54 WRITE FUNCTION                                  *}
{****************************************************************************}

Function        i_APCI1710_WriteTimerValue      (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte;
						 b_TimerNbr    : Byte;
						 ul_WriteValue : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{*                    82X54 KRNL FUNCTION                                   *}
{****************************************************************************}

Function        i_APCI1710_KRNL_ReadTimerValue          (     ui_BaseAddress : Word;
							       b_ModulNbr    : Byte;
							       b_TimerNbr    : Byte;
							 Var pul_TimerValue  : LongInt):Integer;Far;StdCall;

Function        i_APCI1710_KRNL_ReadAllTimerValue       (     ui_BaseAddress     : Word;
							       b_ModulNbr        : Byte;
							 Var pul_TimerValueArray : LongInt):Integer;Far;StdCall;

Function        i_APCI1710_KRNL_WriteTimerValue         (ui_BaseAddress : Word;
							 b_ModulNbr     : Byte;
							 b_TimerNbr     : Byte;
							 ul_WriteValue  : LongInt):Integer;Far;StdCall;



{****************************************************************************}
{*   CHRONO.C                                                               *}
{****************************************************************************}


{****************************************************************************}
{*                      CHRONOMETER INISIALISATION FUNCTION                 *}
{****************************************************************************}

Function   i_APCI1710_InitChrono        (      b_BoardHandle        : Byte;
					       b_ModulNbr           : Byte;
					       b_ChronoMode         : Byte;
					       b_PCIInputClock      : Byte;
					       b_TimingUnity        : Byte;
					      ul_TimingInterval     : LongInt;
					 Var pul_RealTimingInterval : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_EnableChrono      (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_CycleMode       : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;


Function   i_APCI1710_DisableChrono     (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                      CHRONOMETER READ FUNCTION                           *}
{****************************************************************************}

Function   i_APCI1710_GetChronoProgressStatus   (     b_BoardHandle  : Byte;
						      b_ModulNbr     : Byte;
						 Var pb_ChronoStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadChronoValue           (      b_BoardHandle  : Byte;
						       b_ModulNbr     : Byte;
						      ui_TimeOut      : Longint;
						 Var  pb_ChronoStatus : Byte;
						 Var pul_ChronoValue  : LongInt):Integer;Far;StdCall;


Function   i_APCI1710_ConvertChronoValue        (      b_BoardHandle : Byte;
						       b_ModulNbr    : Byte;
						      ul_ChronoValue : LongInt;
						 Var pul_Hour        : LongInt;
						 Var  pb_Minute      : Byte;
						 Var  pb_Second      : Byte;
						 Var pui_MilliSecond : LongInt;
						 Var pui_MicroSecond : LongInt;
						 Var pui_NanoSecond  : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{*                      CHRONOMETER DIGITAL OUTPUT FUNCTION                 *}
{****************************************************************************}

Function   i_APCI1710_SetChronoChlOn    (b_BoardHandle   : Byte;
					 b_ModulNbr      : Byte;
					 b_OutputChannel : Byte):Integer;Far;StdCall;


Function   i_APCI1710_SetChronoChlOff   (b_BoardHandle   : Byte;
					 b_ModulNbr      : Byte;
					 b_OutputChannel : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                      CHRONOMETER DIGITAL INPUT FUNCTION                  *}
{****************************************************************************}

Function   i_APCI1710_ReadChronoChlValue        (     b_BoardHandle   : Byte;
						      b_ModulNbr      : Byte;
						      b_InputChannel  : Byte;
						 Var pb_ChannelStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadChronoPortValue       (     b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						 Var pb_PortValue   : Byte):Integer;Far;StdCall;


{****************************************************************************}
{*                       CHRONOMETER KRNL FUNCTION                          *}
{****************************************************************************}

Function   i_APCI1710_KRNL_GetChronoProgressStatus      (    ui_BaseAddress  : Word;
							      b_ModulNbr     : Byte;
							 Var pb_ChronoStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadChronoValue              (     ui_BaseAddress  : Word;
							       b_ModulNbr     : Byte;
							 Var  pb_ChronoStatus : Byte;
							 Var pul_ChronoValue  : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_SetChronoChlOn               (ui_BaseAddress   : Word;
							  b_ModulNbr      : Byte;
							  b_OutputChannel : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_SetChronoChlOff              (ui_BaseAddress   : Word;
							  b_ModulNbr      : Byte;
							  b_OutputChannel : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadChronoChlValue           (    ui_BaseAddress   : Word;
							      b_ModulNbr      : Byte;
							      b_InputChannel  : Byte;
							 Var pb_ChannelStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadChronoPortValue          (    ui_BaseAddress : Word;
							      b_ModulNbr    : Byte;
							 Var pb_PortValue   : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*   INP_CPT.C                                                              *}
{****************************************************************************}

Function   i_APCI1710_InitPulseEncoder  ( b_BoardHandle         : Byte;
					  b_ModulNbr            : Byte;
					  b_PulseEncoderNbr     : Byte;
					  b_InputLevelSelection : Byte;
					  b_TriggerOutputAction : Byte;
					 ul_StartValue          : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_EnablePulseEncoder        (b_BoardHandle       : Byte;
						 b_ModulNbr          : Byte;
						 b_PulseEncoderNbr   : Byte;
						 b_CycleSelection    : Byte;
						 b_InterruptHandling : Byte):Integer;Far;StdCall;

Function   i_APCI1710_DisablePulseEncoder       (b_BoardHandle     : Byte;
						 b_ModulNbr        : Byte;
						 b_PulseEncoderNbr : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                      READ PULSE ENCODER FUNCTIONS                        *}
{****************************************************************************}

Function   i_APCI1710_ReadPulseEncoderStatus    (     b_BoardHandle     : Byte;
						      b_ModulNbr        : Byte;
						      b_PulseEncoderNbr : Byte;
						 Var pb_Status          : Byte):Integer;Far;StdCall;


Function   i_APCI1710_ReadPulseEncoderValue     (      b_BoardHandle     : Byte;
						       b_ModulNbr        : Byte;
						       b_PulseEncoderNbr : Byte;
						 Var pul_ReadValue       : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{*                      WRITE PULSE ENCODER FUNCTIONS                       *}
{****************************************************************************}

Function   i_APCI1710_WritePulseEncoderValue    ( b_BoardHandle     : Byte;
						  b_ModulNbr        : Byte;
						  b_PulseEncoderNbr : Byte;
						 ul_WriteValue      : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadPulseEncoderValue  (     ui_BaseAddress     : Word;
							 b_ModulNbr        : Byte;
							 b_PulseEncoderNbr : Byte;
						   Var pul_ReadValue       : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_WritePulseEncoderValue  (ui_BaseAddress     : Word;
						     b_ModulNbr        : Byte;
						     b_PulseEncoderNbr : Byte;
						    ul_WriteValue      : LongInt):Integer;Far;StdCall;


{****************************************************************************}
{*   TOR.C                                                                  *}
{****************************************************************************}

Function   i_APCI1710_InitTorCounter    (      b_BoardHandle        : Byte;
					       b_ModulNbr           : Byte;
					       b_TorCounter         : Byte;
					       b_PCIInputClock      : Byte;
					       b_TimingUnity        : Byte;
					      ul_TimingInterval     : LongInt;
					 Var pul_RealTimingInterval : LongInt):Integer;Far;StdCall;


Function   i_APCI1710_EnableTorCounter  (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_TorCounter      : Byte;
					 b_InputMode       : Byte;
					 b_ExternGate      : Byte;
					 b_CycleMode       : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;


Function   i_APCI1710_DisableTorCounter (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte;
					 b_TorCounter  : Byte):Integer;Far;StdCall;


Function   i_APCI1710_GetTorCounterInitialisation (      b_BoardHandle     : Byte;
							 b_ModulNbr        : Byte;
							 b_TorCounter      : Byte;
						   Var  pb_TimingUnity     : Byte;
						   Var pul_TimingInterval  : LongInt;
						   Var  pb_InputMode       : Byte;
						   Var  pb_ExternGate      : Byte;
						   Var  pb_CycleMode       : Byte;
						   Var  pb_Enable          : Byte;
						   Var  pb_InterruptEnable : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                      READ TOR COUNTER FUNCTIONS                          *}
{****************************************************************************}

Function   i_APCI1710_GetTorCounterProgressStatus  (     b_BoardHandle      : Byte;
							 b_ModulNbr         : Byte;
							 b_TorCounter       : Byte;
						    Var pb_TorCounterStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadTorCounterValue       (      b_BoardHandle      : Byte;
						       b_ModulNbr         : Byte;
						       b_TorCounter       : Byte;
						 Var  ui_TimeOut          : LongInt;
						 Var  pb_TorCounterStatus : Byte;
						 Var pul_TorCounterValue  : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{*                      TOR_COUNTER KRNL FUNCTION                           *}
{****************************************************************************}

Function   i_APCI1710_KRNL_GetTorCounterProgressStatus (    ui_BaseAddress      : Word;
							     b_ModulNbr         : Byte;
							     b_TorCounter       : Byte;
							Var pb_TorCounterStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadTorCounterValue         (     ui_BaseAddress      : Word;
							      b_ModulNbr         : Byte;
							      b_TorCounter       : Byte;
							Var  pb_TorCounterStatus : Byte;
							Var pul_TorCounterValue  : LongInt):Integer;Far;StdCall;


{****************************************************************************}
{*   PWM.C                                                                  *}
{****************************************************************************}

{****************************************************************************}
{*                     PWM INISIALISATION FUNCTION                          *}
{****************************************************************************}

Function   i_APCI1710_InitPWM   (     b_BoardHandle    : Byte;
				      b_ModulNbr       : Byte;
				      b_PWM            : Byte;
				      b_ClockSelection : Byte;
				      b_TimingUnit     : Byte;
				     ul_LowTiming      : LongInt;
				     ul_HighTiming     : LongInt;
				 Var ul_RealLowTiming  : LongInt;
				 Var ul_RealHighTiming : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_SetNewPWMTiming (b_BoardHandle    : Byte;
				       b_ModulNbr       : Byte;
				       b_PWM            : Byte;
				       b_TimingUnit     : Byte;
				      ul_LowTiming      : LongInt;
				      ul_HighTiming     : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_EnablePWM (b_BoardHandle     : Byte;
				 b_ModulNbr        : Byte;
				 b_PWM             : Byte;
				 b_StartLevel      : Byte;
				 b_StopMode        : Byte;
				 b_StopLevel       : Byte;
				 b_ExternGate      : Byte;
				 b_InterruptEnable : Byte):Integer;Far;StdCall;

Function   i_APCI1710_DisablePWM (b_BoardHandle : Byte;
				  b_ModulNbr    : Byte;
				  b_PWM         : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetPWMInitialisation     (     b_BoardHandle     : Byte;
						     b_ModulNbr        : Byte;
						     b_PWM             : Byte;
						Var  b_TimingUnit      : Byte;
						Var ul_LowTiming       : LongInt;
						Var ul_HighTiming      : LongInt;
						Var  b_StartLevel      : Byte;
						Var  b_StopMode        : Byte;
						Var  b_StopLevel       : Byte;
						Var  b_ExternGate      : Byte;
						Var  b_InterruptEnable : Byte;
						Var  b_Enable          : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetPWMStatus      (    b_BoardHandle      : Byte;
					     b_ModulNbr         : Byte;
					     b_PWM              : Byte;
					 Var b_PWMOutputStatus  : Byte;
					 Var b_ExternGateStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_GetPWMStatus      (   ui_BaseAddress      : Word;
						  b_ModulNbr         : Byte;
						  b_PWM              : Byte;
					      Var b_PWMOutputStatus  : Byte;
					      Var b_ExternGateStatus : Byte):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_SetNewPWMTiming (ui_BaseAddress   : Word;
					    b_ModulNbr       : Byte;
					    b_PWM            : Byte;
					    b_ClockSelection : Byte;
					    b_TimingUnit     : Byte;
					   ul_LowTiming      : LongInt;
					   ul_HighTiming     : LongInt):Integer;Far;StdCall;

{****************************************************************************}
{* ETM.C                                                                    *}
{****************************************************************************}

{****************************************************************************}
{*                    ETM INISIALISATION FUNCTION                           *}
{****************************************************************************}


Function   i_APCI1710_InitETM   (      b_BoardHandle    : Byte;
				       b_ModulNbr       : Byte;
				       b_ClockSelection : Byte;
				       b_TimingUnit     : Byte;
				      ul_Timing         : LongInt;
				 Var pul_RealTiming     : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_EnableETM  (b_BoardHandle      : Byte;
				  b_ModulNbr         : Byte;
				  b_ETM              : Byte;
				  b_EdgeLevel        : Byte;
				  b_TriggerLevel     : Byte;
				  b_CycleMode        : Byte;
				  b_FirstTriggerMode : Byte;
				  b_InterruptEnable  : Byte):Integer;Far;StdCall;

Function   i_APCI1710_DisableETM (b_BoardHandle : Byte;
				  b_ModulNbr    : Byte;
				  b_ETM         : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetETMInitialisation      (     b_BoardHandle      : Byte;
						      b_ModulNbr         : Byte;
						      b_ETM              : Byte;
						 Var pb_TimingUnit       : Byte;
						 Var pul_Timing          : LongInt;
						 Var pb_EdgeLevel        : Byte;
						 Var pb_TriggerLevel     : Byte;
						 Var pb_CycleMode        : Byte;
						 Var pb_FirstTriggerMode : Byte;
						 Var pb_InterruptEnable  : Byte;
						 Var pb_Enable           : Byte):Integer;Far;StdCall;

{****************************************************************************}
{*                      ETM STATUS FUNCTION                                 *}
{****************************************************************************}

Function   i_APCI1710_GetETMProgressStatus     (     b_BoardHandle : Byte;
						     b_ModulNbr    : Byte;
						     b_ETM         : Byte;
						Var pb_ETMStatus   : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadETMValue             (     b_BoardHandle : Byte;
						     b_ModulNbr    : Byte;
						     b_ETM         : Byte;
						     ui_TimeOut    : LongInt;
						Var  pb_ETMStatus  : Byte;
						Var pul_ETMValue   : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_ConvertETMValue          (      b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						     ul_ETMValue    : LongInt;
						Var pul_Hour        : LongInt;
						Var  pb_Minute      : Byte;
						Var  pb_Second      : Byte;
						Var pui_MilliSecond : LongInt;
						Var pui_MicroSecond : LongInt;
						Var pui_NanoSecond  : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_ReadETMTotalTime          (     b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						      b_ETM         : Byte;
						     ui_TimeOut     : LongInt;
						Var  pb_ETMStatus   : Byte;
						Var pul_ETMValue    : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadETMValue        (     ui_BaseAddress : Word;
						      b_ModulNbr    : Byte;
						      b_ETM         : Byte;
						Var  pb_ETMStatus   : Byte;
						Var pul_ETMValue    : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadETMTotalTime    (     ui_BaseAddress : Word;
						      b_ModulNbr    : Byte;
						      b_ETM         : Byte;
						Var pul_ETMValue    : LongInt):Integer;Far;StdCall;


{****************************************************************************}
{*   CDA.C                                                                  *}
{****************************************************************************}

{****************************************************************************}
{*                     CDA INISIALISATION Function                          *}
{****************************************************************************}

Function   i_APCI1710_SetCDAFunctionality       (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte;
						 b_FunctionalitySelection : Byte):Integer;Far;StdCall;

Function   i_APCI1710_InitCDA                   (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte;
						 ul_Step                  : LongInt;
						 ul_Multiplier            : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_EnableCDA                 (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte):Integer;Far;StdCall;

Function   i_APCI1710_DisableCDA                (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte):Integer;Far;StdCall;

Function   i_APCI1710_GetCDAProgressStatus      (     b_BoardHandle       : Byte;
						      b_ModulNbr          : Byte;
						 Var pb_CDAStatus         : Byte;
						 Var pb_FIFOStatus        : Byte;
						 Var pb_Overflow          : Byte):Integer;Far;StdCall;

Function   i_APCI1710_ReadCDAMinAndMaxDifference(     b_BoardHandle       : Byte;
						      b_ModulNbr          : Byte;
						 Var pl_MinDifference     : LongInt;
						 Var pl_MaxDifference     : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_ReadCDAArrayFromFIFO      (    b_BoardHandle        : Byte;
						     b_ModulNbr           : Byte;
						     ul_NumberOfElement   : LongInt;
						 Var pl_DifferenceArray   : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_ReadCDAArrayFromFIFO (     ui_BaseAddress         : Word;
						      b_ModulNbr             : Byte;
						      ul_NumberOfElement     : LongInt;
						 Var  pl_DifferenceArray     : LongInt;
						 Var  pb_Overflow            : Byte;
						 Var pul_ReadNumberOfElement : LongInt):Integer;Far;StdCall;

Function   i_APCI1710_KRNL_DisableCDA           (ui_BaseAddress : Word;
						  b_ModulNbr    : Byte):Integer;Far;StdCall;


IMPLEMENTATION

{****************************************************************************}
{*   APCI1710.C                                                             *}
{****************************************************************************}

Function   i_APCI1710_InitCompiler              (b_CompilerDefine : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_CheckAndGetPCISlotNumber  (VAR pb_SlotNumberArray : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_SetBoardInformation       (    b_SlotNumber   : Byte;
						 Var pb_BoardHandle : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetHardwareInformation    (      b_BoardHandle  : Byte;
						 VAR   l_BaseAddress  : LongInt;
						 Var  pb_InterruptNbr : Byte;
						 Var  pb_SlotNumber   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_CloseBoardHandle          (b_BoardHandle : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadRegister (b_BoardHandle : Byte;
                                    b_ModulNbr : Byte;
                                    b_SelectedRegister : Byte;
                                    var dw_ReadValue : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_WriteRegister (b_BoardHandle : Byte;
                                     b_ModulNbr : Byte;
                                     b_SelectedRegister : Byte;
                                     dw_WriteValue : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';


{****************************************************************************}
{*   1710INT.C                                                              *}
{****************************************************************************}

Function   i_APCI1710_SetBoardIntRoutineWin32     (b_BoardHandle        : Byte;
						   b_UserCallingMode    : Byte;
						   ul_GlobalBufferSize  : LongInt;
						   ppv_UserGloablBuffer : PPointer;
						   v_FunctionName       : Pointer):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_TestInterrupt             (Var  pb_BoardHandle       : Byte;
						 Var  pb_ModuleMask        : Byte;
						 Var pul_InterruptMask     : LongInt;
						 Var pul_CounterLatchValue : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ResetBoardIntRoutine      (b_BoardHandle : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetSharedMemoryPointer      (b_BoardHandle        : Byte;
						  ppv_SharedMemoryRing3Pointer : PPointer;
						  ppv_SharedMemoryRing0Pointer : PPointer):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*   INC_CPT.C                                                              *}
{****************************************************************************}

Function   i_APCI1710_InitCounter               (b_BoardHandle         : Byte;
						 b_ModulNbr            : Byte;
						 b_CounterRange        : Byte;
						 b_FirstCounterModus   : Byte;
						 b_FirstCounterOption  : Byte;
						 b_SecondCounterModus  : Byte;
						 b_SecondCounterOption : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_CounterAutoTest           (     b_BoardHandle : Byte;
						 Var pb_TestStatus  : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ClearCounterValue         (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ClearAllCounterValue      (b_BoardHandle : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_SetInputFilter            (b_BoardHandle   : Byte;
						 b_ModulNbr      : Byte;
						 b_PCIInputClock : Byte;
						 b_Filter        : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


{****************************************************************************}
{*                     READ COUNTER FunctionS                               *}
{****************************************************************************}

Function   i_APCI1710_LatchCounter              (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte;
						 b_LatchReg    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadLatchRegisterStatus   (     b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						      b_LatchReg    : Byte;
						 Var pb_LatchStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadLatchRegisterValue    (      b_BoardHandle : Byte;
						       b_ModulNbr    : Byte;
						       b_LatchReg    : Byte;
						 Var pul_LatchValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnableLatchInterrupt      (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_DisableLatchInterrupt     (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_Read16BitCounterValue     (b_BoardHandle        : Byte;
						 b_ModulNbr           : Byte;
						 b_SelectedCounter    : Byte;
						 Var pl_CounterValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_Read32BitCounterValue     (      b_BoardHandle  : Byte;
						       b_ModulNbr     : Byte;
						 Var pul_CounterValue : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                       WRITE COUNTER FunctionS                            *}
{****************************************************************************}


Function   i_APCI1710_Write16BitCounterValue    (b_BoardHandle     : Byte;
						 b_ModulNbr        : Byte;
						 b_SelectedCounter : Byte;
						 w_WriteValue      : Word):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_Write32BitCounterValue    (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte;
						 ul_WriteValue : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                            INDEX FunctionS                               *}
{****************************************************************************}


Function   i_APCI1710_InitIndex         (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_ReferenceAction : Byte;
					 b_IndexOperation  : Byte;
					 b_AutoMode        : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnableIndex       (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_DisableIndex      (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetIndexStatus    (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_IndexStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function  i_APCI1710_SetIndexAndReferenceSource (b_BoardHandle     : Byte;
						 b_ModulNbr        : Byte;
						 b_SourceSelection : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


{****************************************************************************}
{*                            REFERENCE FunctionS                           *}
{****************************************************************************}

Function   i_APCI1710_InitReference     (b_BoardHandle    : Byte;
					 b_ModulNbr       : Byte;
					 b_ReferenceLevel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetReferenceStatus (    b_BoardHandle     : Byte;
					      b_ModulNbr        : Byte;
					 Var pb_ReferenceStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                            UAS;CBx;U/D# FunctionS                        *}
{****************************************************************************}

Function   i_APCI1710_GetUASStatus      (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_UASStatus   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetCBStatus       (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_CBStatus    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_Get16BitCBStatus	(     b_BoardHandle      : Byte;
					      b_ModulNbr         : Byte;
					 Var pb_CBStatusCounter0 : Byte;
					 Var pb_CBStatusCounter1 : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_GetUDStatus       (     b_BoardHandle : Byte;
					      b_ModulNbr    : Byte;
					 Var pb_UDStatus    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetInterruptUDLatchedStatus       (     b_BoardHandle : Byte;
							      b_ModulNbr    : Byte;
							 Var pb_UDStatus    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_InitExternalStrobe                (b_BoardHandle         : Byte;
							 b_ModulNbr            : Byte;
							 b_ExternalStrobe      : Byte;
							 b_ExternalStrobeLevel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


(****************************************************************************)
(*                            Compare FunctionS                             *)
(****************************************************************************)

Function        i_APCI1710_InitCompareLogic    ( b_BoardHandle  : Byte;
						 b_ModulNbr     : Byte;
						ui_CompareValue : Longint):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_EnableCompareLogic  (b_BoardHandle   : Byte;
						b_ModulNbr      : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_DisableCompareLogic (b_BoardHandle   : Byte;
						b_ModulNbr      : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

(****************************************************************************)
(*                 Frequency measurement FunctionS                          *)
(****************************************************************************)


Function   i_APCI1710_InitFrequencyMeasurement    (      b_BoardHandle        : Byte;
							 b_ModulNbr           : Byte;
							 b_PCIInputClock      : Byte;
							 b_TimingUnity        : Byte;
							ul_TimingInterval     : LongInt;
						   Var pul_RealTimingInterval : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnableFrequencyMeasurement  (b_BoardHandle     : Byte;
						   b_ModulNbr        : Byte;
						   b_InterruptEnable : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadFrequencyMeasurement    (      b_BoardHandle : Byte;
							 b_ModulNbr    : Byte;
						   Var  pb_Status      : Byte;
						   Var  pb_UDStatus    : Byte;
						   Var pul_ReadValue   : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_DisableFrequencyMeasurement (b_BoardHandle : Byte;
						   b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                     Digital output FUNCTIONS                             *}
{****************************************************************************}

Function   i_APCI1710_SetDigitalChlOn           (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_SetDigitalChlOff          (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


{****************************************************************************}
{*                            KRNL FunctionS                                *}
{****************************************************************************}

Function   i_APCI1710_KRNL_ClearCounterValue       (ui_BaseAddress : Word;
						     b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadLatchRegisterValue   (    ui_BaseAddress   : Word;
							  b_ModulNbr      : Byte;
							  b_LatchReg      : Byte;
						    Var pul_LatchValue    : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_Read16BitCounterValue   (     ui_BaseAddress     : Word;
							  b_ModulNbr        : Byte;
							  b_SelectedCounter : Byte;
						    Var pui_CounterValue    : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_Read32BitCounterValue   (     ui_BaseAddress  : Word;
							  b_ModulNbr     : Byte;
						    Var pul_CounterValue : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_Write16BitCounterValue  (ui_BaseAddress     : Word;
						     b_ModulNbr        : Byte;
						     b_SelectedCounter : Byte;
						    ui_WriteValue      : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_Write32BitCounterValue  (ui_BaseAddress : Word;
						     b_ModulNbr    : Byte;
						    ul_WriteValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_GetInterruptUDLatchedStatus  (    ui_BaseAddress : Word;
							      b_ModulNbr    : Byte;
							 Var pb_UDStatus    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadFrequencyMeasurement     (     ui_BaseAddress : Word;
							       b_ModulNbr    : Byte;
							 Var  pb_Status      : Byte;
							 Var  pb_UDStatus    : Byte;
							 Var pul_ReadValue   : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_SetDigitalChlOn              (ui_BaseAddress : Word;
							  b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_SetDigitalChlOff             (ui_BaseAddress : Word;
							  b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_InitCompareLogic             (ui_BaseAddress  : Word;
							  b_ModulNbr     : Byte;
							 ui_CompareValue : Longint):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*   SSI.C                                                                  *}
{****************************************************************************}

Function   i_APCI1710_InitSSI           ( b_BoardHandle        : Byte;
					  b_ModulNbr           : Byte;
					  b_SSIProfile         : Byte;
					  b_PositionTurnLength : Byte;
					  b_TurnCptLength      : Byte;
					  b_PCIInputClock      : Byte;
					 ul_SSIOutputClock     : LongInt;
					  b_SSICountingMode    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_Read1SSIValue     (      b_BoardHandle : BYte;
					       b_ModulNbr    : Byte;
					       b_SelectedSSI : Byte;
					 Var pul_Position    : LongInt;
					 Var pul_TurnCpt     : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_ReadAllSSIValue   (      b_BoardHandle : Byte;
					       b_ModulNbr    : Byte;
					 Var pul_Position    : LongInt;
					 Var pul_TurnCpt     : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                     SSI DIGITAL INPUT Function                           *}
{****************************************************************************}

Function   i_APCI1710_ReadSSI1DigitalInput   (     b_BoardHandle   : Byte;
						   b_ModulNbr      : Byte;
						   b_InputChannel  : Byte;
					      Var pb_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadSSIAllDigitalInput (     b_BoardHandle : Byte;
						   b_ModulNbr    : Byte;
					      Var pb_InputStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                     SSI DIGITAL OUTPUT Function                          *}
{****************************************************************************}

Function   i_APCI1710_SetSSIDigitalOutputOn  (b_BoardHandle : Byte;
					      b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_SetSSIDigitalOutputOff (b_BoardHandle : Byte;
					      b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


{******************************************************************************}
{*                            SSI KRNL FUNCTIONS                              *}
{******************************************************************************}

Function   i_APCI1710_KRNL_ReadSSI1DigitalInput   (   ui_BaseAddress   : Word;
						       b_ModulNbr      : Byte;
						       b_InputChannel  : Byte;
						   Var b_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadSSIAllDigitalInput (   ui_BaseAddress : Word;
						       b_ModulNbr    : Byte;
						   Var b_InputStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_SetSSIDigitalOutputOn  (ui_BaseAddress : Word;
						    b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_SetSSIDigitalOutputOff (ui_BaseAddress : Word;
						    b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{******************************************************************************}
{*   TTL.C                                                                    *}
{******************************************************************************}

Function        i_APCI1710_InitTTLIO                 (b_BoardHandle : Byte;
						      b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_InitTTLIODirection	     (b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						      b_PortAMode   : Byte;
						      b_PortBMode   : Byte;
						      b_PortCMode   : Byte;
						      b_PortDMode   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_ReadTTLIOChannelValue     (     b_BoardHandle   : Byte;
							   b_ModulNbr      : Byte;
							   b_SelectedPort  : Byte;
							   b_InputChannel  : Byte;
						      Var pb_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_ReadTTLIOPortValue        (    b_BoardHandle  : Byte;
							  b_ModulNbr     : Byte;
							  b_SelectedPort : Byte;
						      Var pb_PortValue   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_ReadTTLIOAllPortValue     (      b_BoardHandle : Byte;
							    b_ModulNbr    : Byte;
						      Var pul_PortValue   : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetTTLIOChlOn             (b_BoardHandle   : Byte;
						      b_ModulNbr      : Byte;
						      b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetTTLIOChlOff            (b_BoardHandle   : Byte;
						      b_ModulNbr      : Byte;
						      b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


{******************************************************************************}
{*                            TTL KRNL FUNCTIONS                              *}
{******************************************************************************}

Function        i_APCI1710_KRNL_ReadTTLIOChannelValue  (  ui_BaseAddress     : Word;
							   b_ModulNbr        : Byte;
							   b_SelectedPort    : Byte;
							   b_InputChannel    : Byte;
							Var pb_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_ReadTTLIOPortValue     (    ui_BaseAddress  : Word;
							     b_ModulNbr     : Byte;
							     b_SelectedPort : Byte;
							Var pb_PortValue    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_ReadTTLIOAllPortValue  (     ui_BaseAddress : Word;
							      b_ModulNbr    : Byte;
							Var pul_PortValue   : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_SetTTLIOChlOn           (ui_BaseAddress  : Word;
							 b_ModulNbr      : Byte;
							 b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_SetTTLIOChlOff          (ui_BaseAddress  : Word;
							 b_ModulNbr      : Byte;
							 b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{******************************************************************************}
{*   DIG_IO.C                                                                 *}
{******************************************************************************}

Function        i_APCI1710_InitDigitalIO               (b_BoardHandle  : Byte;
							b_ModulNbr     : Byte;
							b_ChannelAMode : Byte;
							b_ChannelBMode : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_ReadDigitalIOChlValue       (     b_BoardHandle   : Byte;
							     b_ModulNbr      : Byte;
							     b_InputChannel  : Byte;
							Var pb_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_ReadDigitalIOPortValue      (     b_BoardHandle : Byte;
							     b_ModulNbr    : Byte;
							Var pb_PortValue   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetDigitalIOMemoryOn        (b_BoardHandle : Byte;
							b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetDigitalIOMemoryOff       (b_BoardHandle : Byte;
							b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetDigitalIOChlOn           (b_BoardHandle   : Byte;
							b_ModulNbr      : Byte;
							b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetDigitalIOChlOff          (b_BoardHandle   : Byte;
							b_ModulNbr      : Byte;
							b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetDigitalIOPortOn          (b_BoardHandle : Byte;
							b_ModulNbr    : Byte;
							b_PortValue   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_SetDigitalIOPortOff         (b_BoardHandle : Byte;
							b_ModulNbr    : Byte;
							b_PortValue   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{******************************************************************************}
{*                            KRNL FUNCTIONS                                  *}
{******************************************************************************}

{******************************************************************************}
{*                          INPUT FUNCTIONS                                   *}
{******************************************************************************}

Function        i_APCI1710_KRNL_ReadDigitalIOChlValue      (    ui_BaseAddress   : Word;
								 b_ModulNbr      : Byte;
								 b_InputChannel  : Byte;
							    Var pb_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_ReadDigitalIOPortValue     (   ui_BaseAddress : Word;
								b_ModulNbr    : Byte;
							    Var pb_PortValue  : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                          OUTPUT FUNCTIONS                                *}
{****************************************************************************}

Function        i_APCI1710_KRNL_SetDigitalIOChlOn            (ui_BaseAddress   : Word;
							       b_ModulNbr      : Byte;
							       b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_SetDigitalIOPortOn           (ui_BaseAddress : Word;
							       b_ModulNbr    : Byte;
							       b_PortValue   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{******************************************************************************}
{*   82X54.C                                                                  *}
{******************************************************************************}

{****************************************************************************}
{*                     82X54 TIMER INISIALISATION FUNCTION                  *}
{****************************************************************************}


Function        i_APCI1710_InitTimer    (b_BoardHandle         : Byte;
					 b_ModulNbr            : Byte;
					 b_TimerNbr            : Byte;
					 b_TimerMode           : Byte;
					 ul_ReloadValue        : LongInt;
					 b_InputClockSelection : Byte;
					 b_InputClockLevel     : Byte;
					 b_OutputLevel         : Byte;
					 b_HardwareGateLevel   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_EnableTimer  (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_TimerNbr        : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_DisableTimer (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte;
					 b_TimerNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                       82X54 READ FUNCTION                                *}
{****************************************************************************}

Function        i_APCI1710_ReadTimerValue               (      b_BoardHandle : Byte;
							       b_ModulNbr    : Byte;
							       b_TimerNbr    : Byte;
							 Var pul_TimerValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_ReadAllTimerValue            (      b_BoardHandle     : Byte;
							       b_ModulNbr        : Byte;
							 Var pul_TimerValueArray : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_GetTimerOutputLevel          (     b_BoardHandle : Byte;
							      b_ModulNbr    : Byte;
							      b_TimerNbr    : Byte;
							 Var pb_OutputLevel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_GetTimerProgressStatus       (     b_BoardHandle : Byte;
							      b_ModulNbr    : Byte;
							      b_TimerNbr    : Byte;
							 Var pb_TimerStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                    82X54 WRITE FUNCTION                                  *}
{****************************************************************************}

Function        i_APCI1710_WriteTimerValue      (b_BoardHandle : Byte;
						 b_ModulNbr    : Byte;
						 b_TimerNbr    : Byte;
						 ul_WriteValue : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                    82X54 KRNL FUNCTION                                   *}
{****************************************************************************}

Function        i_APCI1710_KRNL_ReadTimerValue          (     ui_BaseAddress : Word;
							       b_ModulNbr    : Byte;
							       b_TimerNbr    : Byte;
							 Var pul_TimerValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_ReadAllTimerValue       (     ui_BaseAddress     : Word;
							       b_ModulNbr        : Byte;
							 Var pul_TimerValueArray : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function        i_APCI1710_KRNL_WriteTimerValue         (ui_BaseAddress : Word;
							 b_ModulNbr     : Byte;
							 b_TimerNbr     : Byte;
							 ul_WriteValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*   CHRONO.C                                                               *}
{****************************************************************************}


{****************************************************************************}
{*                      CHRONOMETER INISIALISATION FUNCTION                 *}
{****************************************************************************}

Function   i_APCI1710_InitChrono        (      b_BoardHandle        : Byte;
					       b_ModulNbr           : Byte;
					       b_ChronoMode         : Byte;
					       b_PCIInputClock      : Byte;
					       b_TimingUnity        : Byte;
					      ul_TimingInterval     : LongInt;
					 Var pul_RealTimingInterval : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnableChrono      (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_CycleMode       : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_DisableChrono     (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      CHRONOMETER READ FUNCTION                           *}
{****************************************************************************}

Function   i_APCI1710_GetChronoProgressStatus   (     b_BoardHandle  : Byte;
						      b_ModulNbr     : Byte;
						 Var pb_ChronoStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadChronoValue           (      b_BoardHandle  : Byte;
						       b_ModulNbr     : Byte;
						      ui_TimeOut      : LongInt;
						 Var  pb_ChronoStatus : Byte;
						 Var pul_ChronoValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_ConvertChronoValue        (      b_BoardHandle : Byte;
						       b_ModulNbr    : Byte;
						      ul_ChronoValue : LongInt;
						 Var pul_Hour        : LongInt;
						 Var  pb_Minute      : Byte;
						 Var  pb_Second      : Byte;
						 Var pui_MilliSecond : LongInt;
						 Var pui_MicroSecond : LongInt;
						 Var pui_NanoSecond  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      CHRONOMETER DIGITAL OUTPUT FUNCTION                 *}
{****************************************************************************}

Function   i_APCI1710_SetChronoChlOn    (b_BoardHandle   : Byte;
					 b_ModulNbr      : Byte;
					 b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_SetChronoChlOff   (b_BoardHandle   : Byte;
					 b_ModulNbr      : Byte;
					 b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      CHRONOMETER DIGITAL INPUT FUNCTION                  *}
{****************************************************************************}

Function   i_APCI1710_ReadChronoChlValue        (     b_BoardHandle   : Byte;
						      b_ModulNbr      : Byte;
						      b_InputChannel  : Byte;
						 Var pb_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadChronoPortValue       (     b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						 Var pb_PortValue   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


{****************************************************************************}
{*                       CHRONOMETER KRNL FUNCTION                          *}
{****************************************************************************}

Function   i_APCI1710_KRNL_GetChronoProgressStatus      (    ui_BaseAddress  : Word;
							      b_ModulNbr     : Byte;
							 Var pb_ChronoStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadChronoValue              (     ui_BaseAddress  : Word;
							       b_ModulNbr     : Byte;
							 Var  pb_ChronoStatus : Byte;
							 Var pul_ChronoValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_SetChronoChlOn               (ui_BaseAddress   : Word;
							  b_ModulNbr      : Byte;
							  b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_SetChronoChlOff              (ui_BaseAddress   : Word;
							  b_ModulNbr      : Byte;
							  b_OutputChannel : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadChronoChlValue           (    ui_BaseAddress   : Word;
							      b_ModulNbr      : Byte;
							      b_InputChannel  : Byte;
							 Var pb_ChannelStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadChronoPortValue          (    ui_BaseAddress : Word;
							      b_ModulNbr    : Byte;
							 Var pb_PortValue   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*   INP_CPT.C                                                              *}
{****************************************************************************}

Function   i_APCI1710_InitPulseEncoder  ( b_BoardHandle         : Byte;
					  b_ModulNbr            : Byte;
					  b_PulseEncoderNbr     : Byte;
					  b_InputLevelSelection : Byte;
					  b_TriggerOutputAction : Byte;
					 ul_StartValue          : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnablePulseEncoder        (b_BoardHandle       : Byte;
						 b_ModulNbr          : Byte;
						 b_PulseEncoderNbr   : Byte;
						 b_CycleSelection    : Byte;
						 b_InterruptHandling : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_DisablePulseEncoder       (b_BoardHandle     : Byte;
						 b_ModulNbr        : Byte;
						 b_PulseEncoderNbr : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      READ PULSE ENCODER FUNCTIONS                        *}
{****************************************************************************}

Function   i_APCI1710_ReadPulseEncoderStatus    (     b_BoardHandle     : Byte;
						      b_ModulNbr        : Byte;
						      b_PulseEncoderNbr : Byte;
						 Var pb_Status          : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_ReadPulseEncoderValue     (      b_BoardHandle     : Byte;
						       b_ModulNbr        : Byte;
						       b_PulseEncoderNbr : Byte;
						 Var pul_ReadValue       : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      WRITE PULSE ENCODER FUNCTIONS                       *}
{****************************************************************************}

Function   i_APCI1710_WritePulseEncoderValue    ( b_BoardHandle     : Byte;
						  b_ModulNbr        : Byte;
						  b_PulseEncoderNbr : Byte;
						 ul_WriteValue      : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadPulseEncoderValue  (     ui_BaseAddress     : Word;
							 b_ModulNbr        : Byte;
							 b_PulseEncoderNbr : Byte;
						   Var pul_ReadValue       : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_WritePulseEncoderValue  (ui_BaseAddress     : Word;
						     b_ModulNbr        : Byte;
						     b_PulseEncoderNbr : Byte;
						    ul_WriteValue      : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*   TOR.C                                                                  *}
{****************************************************************************}

Function   i_APCI1710_InitTorCounter    (      b_BoardHandle        : Byte;
					       b_ModulNbr           : Byte;
					       b_TorCounter         : Byte;
					       b_PCIInputClock      : Byte;
					       b_TimingUnity        : Byte;
					      ul_TimingInterval     : LongInt;
					 Var pul_RealTimingInterval : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_EnableTorCounter  (b_BoardHandle     : Byte;
					 b_ModulNbr        : Byte;
					 b_TorCounter      : Byte;
					 b_InputMode       : Byte;
					 b_ExternGate      : Byte;
					 b_CycleMode       : Byte;
					 b_InterruptEnable : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_DisableTorCounter (b_BoardHandle : Byte;
					 b_ModulNbr    : Byte;
					 b_TorCounter  : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


Function   i_APCI1710_GetTorCounterInitialisation (      b_BoardHandle     : Byte;
							 b_ModulNbr        : Byte;
							 b_TorCounter      : Byte;
						   Var  pb_TimingUnity     : Byte;
						   Var pul_TimingInterval  : LongInt;
						   Var  pb_InputMode       : Byte;
						   Var  pb_ExternGate      : Byte;
						   Var  pb_CycleMode       : Byte;
						   Var  pb_Enable          : Byte;
						   Var  pb_InterruptEnable : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      READ TOR COUNTER FUNCTIONS                          *}
{****************************************************************************}

Function   i_APCI1710_GetTorCounterProgressStatus  (     b_BoardHandle      : Byte;
							 b_ModulNbr         : Byte;
							 b_TorCounter       : Byte;
						    Var pb_TorCounterStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadTorCounterValue       (      b_BoardHandle      : Byte;
						       b_ModulNbr         : Byte;
						       b_TorCounter       : Byte;
						 Var  ui_TimeOut          : LongInt;
						 Var  pb_TorCounterStatus : Byte;
						 Var pul_TorCounterValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      TOR_COUNTER KRNL FUNCTION                           *}
{****************************************************************************}

Function   i_APCI1710_KRNL_GetTorCounterProgressStatus (    ui_BaseAddress      : Word;
							     b_ModulNbr         : Byte;
							     b_TorCounter       : Byte;
							Var pb_TorCounterStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadTorCounterValue         (     ui_BaseAddress      : Word;
							      b_ModulNbr         : Byte;
							      b_TorCounter       : Byte;
							Var  pb_TorCounterStatus : Byte;
							Var pul_TorCounterValue  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*   PWM.C                                                                  *}
{****************************************************************************}

{****************************************************************************}
{*                     PWM INISIALISATION FUNCTION                          *}
{****************************************************************************}

Function   i_APCI1710_InitPWM   (     b_BoardHandle    : Byte;
				      b_ModulNbr       : Byte;
				      b_PWM            : Byte;
				      b_ClockSelection : Byte;
				      b_TimingUnit     : Byte;
				     ul_LowTiming      : LongInt;
				     ul_HighTiming     : LongInt;
				 Var ul_RealLowTiming  : LongInt;
				 Var ul_RealHighTiming : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_SetNewPWMTiming (b_BoardHandle    : Byte;
				       b_ModulNbr       : Byte;
				       b_PWM            : Byte;
				       b_TimingUnit     : Byte;
				      ul_LowTiming      : LongInt;
				      ul_HighTiming     : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnablePWM (b_BoardHandle     : Byte;
				 b_ModulNbr        : Byte;
				 b_PWM             : Byte;
				 b_StartLevel      : Byte;
				 b_StopMode        : Byte;
				 b_StopLevel       : Byte;
				 b_ExternGate      : Byte;
				 b_InterruptEnable : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_DisablePWM (b_BoardHandle : Byte;
				  b_ModulNbr    : Byte;
				  b_PWM         : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetPWMInitialisation     (     b_BoardHandle     : Byte;
						     b_ModulNbr        : Byte;
						     b_PWM             : Byte;
						Var  b_TimingUnit      : Byte;
						Var ul_LowTiming       : LongInt;
						Var ul_HighTiming      : LongInt;
						Var  b_StartLevel      : Byte;
						Var  b_StopMode        : Byte;
						Var  b_StopLevel       : Byte;
						Var  b_ExternGate      : Byte;
						Var  b_InterruptEnable : Byte;
						Var  b_Enable          : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetPWMStatus      (    b_BoardHandle      : Byte;
					     b_ModulNbr         : Byte;
					     b_PWM              : Byte;
					 Var b_PWMOutputStatus  : Byte;
					 Var b_ExternGateStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_GetPWMStatus      (   ui_BaseAddress      : Word;
						  b_ModulNbr         : Byte;
						  b_PWM              : Byte;
					      Var b_PWMOutputStatus  : Byte;
					      Var b_ExternGateStatus : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_SetNewPWMTiming (ui_BaseAddress   : Word;
					    b_ModulNbr       : Byte;
					    b_PWM            : Byte;
					    b_ClockSelection : Byte;
					    b_TimingUnit     : Byte;
					   ul_LowTiming      : LongInt;
					   ul_HighTiming     : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{* ETM.C                                                                    *}
{****************************************************************************}

{****************************************************************************}
{*                    ETM INISIALISATION FUNCTION                           *}
{****************************************************************************}


Function   i_APCI1710_InitETM   (      b_BoardHandle    : Byte;
				       b_ModulNbr       : Byte;
				       b_ClockSelection : Byte;
				       b_TimingUnit     : Byte;
				      ul_Timing         : LongInt;
				 Var pul_RealTiming     : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnableETM  (b_BoardHandle      : Byte;
				  b_ModulNbr         : Byte;
				  b_ETM              : Byte;
				  b_EdgeLevel        : Byte;
				  b_TriggerLevel     : Byte;
				  b_CycleMode        : Byte;
				  b_FirstTriggerMode : Byte;
				  b_InterruptEnable  : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_DisableETM (b_BoardHandle : Byte;
				  b_ModulNbr    : Byte;
				  b_ETM         : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetETMInitialisation      (     b_BoardHandle      : Byte;
						      b_ModulNbr         : Byte;
						      b_ETM              : Byte;
						 Var pb_TimingUnit       : Byte;
						 Var pul_Timing          : LongInt;
						 Var pb_EdgeLevel        : Byte;
						 Var pb_TriggerLevel     : Byte;
						 Var pb_CycleMode        : Byte;
						 Var pb_FirstTriggerMode : Byte;
						 Var pb_InterruptEnable  : Byte;
						 Var pb_Enable           : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*                      ETM STATUS FUNCTION                                 *}
{****************************************************************************}

Function   i_APCI1710_GetETMProgressStatus     (     b_BoardHandle : Byte;
						     b_ModulNbr    : Byte;
						     b_ETM         : Byte;
						Var pb_ETMStatus   : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadETMValue             (     b_BoardHandle : Byte;
						     b_ModulNbr    : Byte;
						     b_ETM         : Byte;
						     ui_TimeOut    : LongInt;
						Var  pb_ETMStatus  : Byte;
						Var pul_ETMValue   : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ConvertETMValue          (      b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						     ul_ETMValue    : LongInt;
						Var pul_Hour        : LongInt;
						Var  pb_Minute      : Byte;
						Var  pb_Second      : Byte;
						Var pui_MilliSecond : LongInt;
						Var pui_MicroSecond : LongInt;
						Var pui_NanoSecond  : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadETMTotalTime          (     b_BoardHandle : Byte;
						      b_ModulNbr    : Byte;
						      b_ETM         : Byte;
						     ui_TimeOut     : LongInt;
						Var  pb_ETMStatus   : Byte;
						Var pul_ETMValue    : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadETMValue        (     ui_BaseAddress : Word;
						      b_ModulNbr    : Byte;
						      b_ETM         : Byte;
						Var  pb_ETMStatus   : Byte;
						Var pul_ETMValue    : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadETMTotalTime    (     ui_BaseAddress : Word;
						      b_ModulNbr    : Byte;
						      b_ETM         : Byte;
						Var pul_ETMValue    : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

{****************************************************************************}
{*   CDA.C                                                                  *}
{****************************************************************************}

{****************************************************************************}
{*                     CDA INISIALISATION Function                          *}
{****************************************************************************}

Function   i_APCI1710_SetCDAFunctionality       (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte;
						 b_FunctionalitySelection : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_InitCDA                   (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte;
						 ul_Step                  : LongInt;
						 ul_Multiplier            : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_EnableCDA                 (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_DisableCDA                (b_BoardHandle            : Byte;
						 b_ModulNbr               : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_GetCDAProgressStatus      (     b_BoardHandle       : Byte;
						      b_ModulNbr          : Byte;
						 Var pb_CDAStatus         : Byte;
						 Var pb_FIFOStatus        : Byte;
						 Var pb_Overflow          : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadCDAMinAndMaxDifference(     b_BoardHandle       : Byte;
						      b_ModulNbr          : Byte;
						 Var pl_MinDifference     : LongInt;
						 Var pl_MaxDifference     : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_ReadCDAArrayFromFIFO      (    b_BoardHandle        : Byte;
						     b_ModulNbr           : Byte;
						     ul_NumberOfElement   : LongInt;
						 Var pl_DifferenceArray   : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_ReadCDAArrayFromFIFO (     ui_BaseAddress         : Word;
						      b_ModulNbr             : Byte;
						      ul_NumberOfElement     : LongInt;
						 Var  pl_DifferenceArray     : LongInt;
						 Var  pb_Overflow            : Byte;
						 Var pul_ReadNumberOfElement : LongInt):Integer;Far;StdCall;External 'APCI1710.DLL';

Function   i_APCI1710_KRNL_DisableCDA           (ui_BaseAddress : Word;
						  b_ModulNbr    : Byte):Integer;Far;StdCall;External 'APCI1710.DLL';


END.

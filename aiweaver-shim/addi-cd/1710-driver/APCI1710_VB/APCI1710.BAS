Attribute VB_Name = "APCI1710"

'****************************************************************************'
'*   APCI1710.C                                                             *'
'****************************************************************************'

Global Const DLL_COMPILER_C = 0
Global Const DLL_COMPILER_PASCAL = 1
Global Const DLL_COMPILER_VB = 2
Global Const DLL_LABVIEW = 3
Global Const DLL_COMPILER_VB_5 = 4
Global Const APCI1710_DISABLE = 0
Global Const APCI1710_ENABLE = 1
Global Const APCI1710_SYNCHRONOUS_MODE = 1
Global Const APCI1710_ASYNCHRONOUS_MODE = 0

Declare Function i_APCI1710_InitCompiler Lib "APCI1710.DLL" (ByVal b_CompilerDefine As Integer) As Integer

Declare Function i_APCI1710_CheckAndGetPCISlotNumber Lib "APCI1710.DLL" (pb_SlotNumberArray As Integer) As Integer

Declare Function i_APCI1710_SetBoardInformation Lib "APCI1710.DLL" (ByVal b_SlotNumber As Integer, _
                                                                         b_BoardHandle As Integer) As Integer

Declare Function i_APCI1710_GetHardwareInformation Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                         pui_BaseAddress As Long, _
                                                                         pb_InterruptNbr As Integer, _
                                                                         pb_SlotNumber As Integer) As Integer

Declare Function i_APCI1710_CloseBoardHandle Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer) As Integer


'****************************************************************************'
'*   1710INT.C                                                              *'
'****************************************************************************'

Declare Function i_APCI1710_SetBoardIntRoutineWin32 Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                         ByVal b_UserCallingMode As Integer, _
                                                                         ByVal ul_GlobalBufferSize As Long, _
                                                                         ppv_UserGloablBuffer As Any, _
                                                                         ByVal v_FunctionName As Long) As Integer

Declare Function i_APCI1710_TestInterrupt Lib "APCI1710.DLL" (pb_BoardHandle As Integer, _
                                                                         pb_ModuleMask As Integer, _
                                                                         pul_InterruptMask As Long, _
                                                                         pul_CounterLatchValue As Long) As Integer

Declare Function i_APCI1710_ResetBoardIntRoutine Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer) As Integer

'****************************************************************************'
'*   INC_CPT.C                                                              *'
'****************************************************************************'


Global Const APCI1710_16BIT_COUNTER = &H10
Global Const APCI1710_32BIT_COUNTER = &H0
Global Const APCI1710_QUADRUPLE_MODE = &H0
Global Const APCI1710_DOUBLE_MODE = &H3
Global Const APCI1710_SIMPLE_MODE = &HF
Global Const APCI1710_DIRECT_MODE = &H80
Global Const APCI1710_HYSTERESIS_ON = &H60
Global Const APCI1710_HYSTERESIS_OFF = &H0
Global Const APCI1710_INCREMENT = &H60
Global Const APCI1710_DECREMENT = &H0
Global Const APCI1710_LATCH_COUNTER = &H1
Global Const APCI1710_CLEAR_COUNTER = &H0
Global Const PCI1710_LOW = &H0
Global Const APCI1710_HIGH = &H1
Global Const APCI1710_INDEX_LATCH_COUNTER = &H10
Global Const APCI1710_INDEX_AUTO_MODE = &H8

Global Const APCI1710_HIGH_EDGE_CLEAR_COUNTER = &H0
Global Const APCI1710_HIGH_EDGE_LATCH_COUNTER = &H1
Global Const APCI1710_LOW_EDGE_CLEAR_COUNTER = &H2
Global Const APCI1710_LOW_EDGE_LATCH_COUNTER = &H3
Global Const APCI1710_HIGH_EDGE_LATCH_AND_CLEAR_COUNTER = &H4
Global Const APCI1710_LOW_EDGE_LATCH_AND_CLEAR_COUNTER = &H5
Global Const APCI1710_SOURCE_0 = &H0
Global Const APCI1710_SOURCE_1 = &H1


Declare Function i_APCI1710_InitCounter Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                     ByVal b_ModulNbr As Integer, _
                                                                     ByVal b_CounterRange As Integer, _
                                                                     ByVal b_FirstCounterModus As Integer, _
                                                                     ByVal b_FirstCounterOption As Integer, _
                                                                     ByVal b_SecondCounterModus As Integer, _
                                                                     ByVal b_SecondCounterOption As Integer) As Integer

Declare Function i_APCI1710_CounterAutoTest Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                     pb_TestStatus As Integer) As Integer

Declare Function i_APCI1710_ClearCounterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                     ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_ClearAllCounterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer) As Integer

Declare Function i_APCI1710_SetInputFilter Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                               ByVal b_ModulNbr As Integer, _
                                                               ByVal b_PCIInputClock As Integer, _
                                                               ByVal b_Filter As Integer) As Integer



'****************************************************************************'
'*                       READ COUNTER FUNCTIONS                             *'
'****************************************************************************'


Declare Function i_APCI1710_LatchCounter Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_LatchReg As Integer) As Integer

Declare Function i_APCI1710_ReadLatchRegisterStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_LatchReg As Integer, _
                                                                            pb_LatchStatus As Integer) As Integer

Declare Function i_APCI1710_ReadLatchRegisterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_LatchReg As Integer, _
                                                                            pul_LatchValue As Long) As Integer

Declare Function i_APCI1710_EnableLatchInterrupt Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_DisableLatchInterrupt Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_Read16BitCounterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_SelectedCounter As Integer, _
                                                                            pui_CounterValue As Long) As Integer

Declare Function i_APCI1710_Read32BitCounterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            pul_CounterValue As Long) As Integer


'****************************************************************************'
'*                       WRITE COUNTER FUNCTIONS                            *'
'****************************************************************************'

Declare Function i_APCI1710_Write16BitCounterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_SelectedCounter As Integer, _
                                                                            ByVal ui_WriteValue As Long) As Integer

Declare Function i_APCI1710_Write32BitCounterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal ul_WriteValue As Long) As Integer


'****************************************************************************'
'*                            INDEX FUNCTIONS                               *'
'****************************************************************************'



Declare Function i_APCI1710_InitIndex Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                          ByVal b_ModulNbr As Integer, _
                                                          ByVal b_ReferenceAction As Integer, _
                                                          ByVal b_IndexOperation As Integer, _
                                                          ByVal b_AutoMode As Integer, _
                                                          ByVal b_InterruptEnable As Integer) As Integer

Declare Function i_APCI1710_EnableIndex Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                            ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_DisableIndex Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                             ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_GetIndexStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                               ByVal b_ModulNbr As Integer, _
                                                               pb_IndexStatus As Integer) As Integer

Declare Function i_APCI1710_SetIndexAndReferenceSource Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                           ByVal b_ModulNbr As Integer, _
                                                                           ByVal b_SourceSelection As Integer) As Integer


'****************************************************************************'
'*                            REFERENCE FUNCTIONS                           *'
'****************************************************************************'

Declare Function i_APCI1710_InitReference Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_ReferenceLevel As Integer) As Integer

Declare Function i_APCI1710_GetReferenceStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            pb_ReferenceStatus As Integer) As Integer


'****************************************************************************'
'*                            UAS,CBx,U/D# FUNCTIONS                        *'
'****************************************************************************'


Declare Function i_APCI1710_GetUASStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
									    pb_UASStatus As Integer) As Integer

Declare Function i_APCI1710_GetCBStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
							    ByVal b_ModulNbr As Integer, _
							    pb_CBStatus As Integer) As Integer

Declare Function i_APCI1710_Get16BitCBStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle  As Integer, _
								 ByVal b_ModulNbr     As Integer, _
								 pb_CBStatusCounter0  As Integer, _
								 pb_CBStatusCounter1  As Integer) As Integer


Declare Function i_APCI1710_GetUDStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            pb_UDStatus As Integer) As Integer

Declare Function i_APCI1710_GetInterruptUDLatchedStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            pb_UDStatus As Integer) As Integer

Declare Function i_APCI1710_InitExternalStrobe Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_ExternalStrobe As Integer, _
                                                                            ByVal b_ExternalStrobeLevel As Integer) As Integer


'****************************************************************************'
'*                            Compare FUNCTIONS                             *'
'****************************************************************************'

Declare Function i_APCI1710_InitCompareLogic Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal ui_CompareValue As Long) As Integer

Declare Function i_APCI1710_EnableCompareLogic Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_DisableCompareLogic Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer) As Integer

'****************************************************************************'
'*                      Frequency measurement FUNCTIONS                     *'
'****************************************************************************'

Declare Function i_APCI1710_InitFrequencyMeasurement Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_PCIInputClock As Integer, _
                                                                            ByVal b_TimingUnity As Integer, _
                                                                            ByVal ul_TimingInterval As Long, _
                                                                                 pul_RealTimingInterval As Long) As Integer

Declare Function i_APCI1710_EnableFrequencyMeasurement Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_InterruptEnable As Integer) As Integer

Declare Function i_APCI1710_ReadFrequencyMeasurement Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                                 pb_Status As Integer, _
                                                                                 pb_UDStatus As Integer, _
                                                                                pul_ReadValue As Long) As Integer

Declare Function i_APCI1710_DisableFrequencyMeasurement Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer) As Integer

'****************************************************************************'
'*                      Digital output FUNCTIONS                            *'
'****************************************************************************'

Declare Function i_APCI1710_SetDigitalChlOn Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_SetDigitalChlOff Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer) As Integer



'****************************************************************************'
'*   SSI.C                                                                  *'
'****************************************************************************'

Global Const APCI1710_30MHZ = 30
Global Const APCI1710_33MHZ = 33
Global Const APCI1710_40MHZ = 40
Global Const APCI1710_BINARY_MODE = 1
Global Const APCI1710_GRAY_MODE = 0



'****************************************************************************'
'*                       SSI INISIALISATION FUNCTION                        *'
'****************************************************************************'


Declare Function i_APCI1710_InitSSI Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_SSIProfile As Integer, _
                                                                            ByVal b_PositionTurnLength As Integer, _
                                                                            ByVal b_TurnCptLength As Integer, _
                                                                            ByVal b_PCIInputClock As Integer, _
                                                                            ByVal ul_SSIOutputClock As Long, _
                                                                            ByVal b_SSICountingMode As Integer) As Integer

Declare Function i_APCI1710_Read1SSIValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_SelectedSSI As Integer, _
                                                                            pul_Position As Long, _
                                                                            pul_TurnCpt As Long) As Integer


Declare Function i_APCI1710_ReadAllSSIValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            pul_Position As Long, _
                                                                            pul_TurnCpt As Long) As Integer

Declare Function i_APCI1710_ReadSSI1DigitalInput Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                     ByVal b_ModulNbr As Integer, _
                                                                     ByVal b_InputChannel As Integer, _
                                                                     pb_ChannelStatus As Integer) As Integer

Declare Function i_APCI1710_ReadSSIAllDigitalInput Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                       ByVal b_ModulNbr As Integer, _
                                                                       pb_InputStatus As Integer) As Integer

Declare Function i_APCI1710_SetSSIDigitalOutputOn Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                      ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_SetSSIDigitalOutputOff Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                       ByVal b_ModulNbr As Integer) As Integer

'****************************************************************************'
'*   TTL.C                                                                  *'
'****************************************************************************'


'****************************************************************************'
'*                      TTL INISIALISATION FUNCTION                         *'
'****************************************************************************'


Declare Function i_APCI1710_InitTTLIO Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                          ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_InitTTLIODirection Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                   ByVal b_ModulNbr As Integer, _
                                                                   ByVal b_PortAMode As Integer, _
                                                                   ByVal b_PortBMode As Integer, _
                                                                   ByVal b_PortCMode As Integer, _
                                                                   ByVal b_PortDMode As Integer) As Integer


'****************************************************************************'
'*                       TTL INPUT FUNCTION                                 *'
'****************************************************************************'


Declare Function i_APCI1710_ReadTTLIOChannelValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                    ByVal b_ModulNbr As Integer, _
                                                                                    ByVal b_SelectedPort As Integer, _
                                                                                    ByVal b_InputChannel As Integer, _
                                                                                         pb_ChannelStatus As Integer) As Integer

Declare Function i_APCI1710_ReadTTLIOPortValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                   ByVal b_ModulNbr As Integer, _
                                                                                   ByVal b_SelectedPort As Integer, _
                                                                                        pb_PortValue As Integer) As Integer

Declare Function i_APCI1710_ReadTTLIOAllPortValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                   ByVal b_ModulNbr As Integer, _
                                                                                       pul_PortValue As Long) As Integer

'****************************************************************************'
'*                       TTL OUTPUT FUNCTION                                *'
'****************************************************************************'

Declare Function i_APCI1710_SetTTLIOChlOn Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                 ByVal b_ModulNbr As Integer, _
                                                                                 ByVal b_OutputChannel As Integer) As Integer

Declare Function i_APCI1710_SetTTLIOChlOff Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                 ByVal b_ModulNbr As Integer, _
                                                                                 ByVal b_OutputChannel As Integer) As Integer


'****************************************************************************'
'*   DIG_IO.C                                                               *'
'****************************************************************************'

'****************************************************************************'
'*                 DIGITAL I/O INISIALISATION FUNCTION                      *'
'****************************************************************************'

Declare Function i_APCI1710_InitDigitalIO Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer, _
                                                                        ByVal b_ChannelAMode As Integer, _
                                                                        ByVal b_ChannelBMode As Integer) As Integer

'****************************************************************************'
'*                       DIGITAL I/O INPUT FUNCTION                         *'
'****************************************************************************'

Declare Function i_APCI1710_ReadDigitalIOChlValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer, _
                                                                        ByVal b_InputChannel As Integer, _
                                                                             pb_ChannelStatus As Integer) As Integer

Declare Function i_APCI1710_ReadDigitalIOPortValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer, _
                                                                             pb_PortValue As Integer) As Integer

'****************************************************************************'
'*                       DIGITAL I/O OUTPUT FUNCTION                        *'
'****************************************************************************'

Declare Function i_APCI1710_SetDigitalIOMemoryOn Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_SetDigitalIOMemoryOff Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_SetDigitalIOChlOn Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer, _
                                                                        ByVal b_OutputChannel As Integer) As Integer

Declare Function i_APCI1710_SetDigitalIOChlOff Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer, _
                                                                        ByVal b_OutputChannel As Integer) As Integer

Declare Function i_APCI1710_SetDigitalIOPortOn Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer, _
                                                                        ByVal b_PortValue As Integer) As Integer

Declare Function i_APCI1710_SetDigitalIOPortOff Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                        ByVal b_ModulNbr As Integer, _
                                                                        ByVal b_PortValue As Integer) As Integer

'****************************************************************************'
'*                       82X54 TIMER INISIALISATION FUNCTION                *'
'****************************************************************************'

Const APCI1710_PCI_BUS_CLOCK = 0
Const APCI1710_FRONT_CONNECTOR_INPUT = 1

Declare Function i_APCI1710_InitTimer Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal b_TimerNbr As Integer, _
                                                                    ByVal b_TimerMode As Integer, _
                                                                    ByVal ul_ReloadValue As Integer, _
                                                                    ByVal b_InputClockSelection As Long, _
                                                                    ByVal b_InputClockLevel As Integer, _
                                                                    ByVal b_OutputLevel As Integer, _
                                                                    ByVal b_HardwareGateLevel As Integer) As Integer

Declare Function i_APCI1710_EnableTimer Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal b_TimerNbr As Integer, _
                                                                    ByVal b_InterruptEnable As Integer) As Integer

Declare Function i_APCI1710_DisableTimer Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal b_TimerNbr As Integer) As Integer

'****************************************************************************'
'*                       82X54 READ FUNCTION                                *'
'****************************************************************************'


Declare Function i_APCI1710_ReadTimerValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_TimerNbr As Integer, _
                                                                                pul_TimerValue As Long) As Integer

Declare Function i_APCI1710_ReadAllTimerValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                                pul_TimerValueArray As Long) As Integer

Declare Function i_APCI1710_GetTimerOutputLevel Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_TimerNbr As Integer, _
                                                                                 pb_OutputLevel As Integer) As Integer

Declare Function i_APCI1710_GetTimerProgressStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_TimerNbr As Integer, _
                                                                                 pb_TimerStatus As Integer) As Integer

'****************************************************************************'
'*                       82X54 WRITE FUNCTION                               *'
'****************************************************************************'

Declare Function i_APCI1710_WriteTimerValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal b_TimerNbr As Integer, _
                                                                    ByVal ul_WriteValue As Long) As Integer


'****************************************************************************'
'*   CHRONO.C                                                               *'
'****************************************************************************'

Global Const APCI1710_SINGLE = 0
Global Const APCI1710_CONTINUOUS = 1

'****************************************************************************'
'*                      CHRONOMETER INISIALISATION FUNCTION                 *'
'****************************************************************************'

Declare Function i_APCI1710_InitChrono Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                               ByVal b_ModulNbr As Integer, _
                                                               ByVal b_ChronoMode As Integer, _
                                                               ByVal b_PCIInputClock As Integer, _
                                                               ByVal b_TimingUnity As Integer, _
                                                               ByVal ul_TimingInterval As Long, _
                                                                     pul_RealTimingInterval As Long) As Integer

Declare Function i_APCI1710_EnableChrono Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                               ByVal b_ModulNbr As Integer, _
                                                               ByVal b_CycleMode As Integer, _
                                                               ByVal b_InterruptEnable As Integer) As Integer


Declare Function i_APCI1710_DisableChrono Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                               ByVal b_ModulNbr As Integer) As Integer

'****************************************************************************'
'*                      CHRONOMETER READ FUNCTION                           *'
'****************************************************************************'

Declare Function i_APCI1710_GetChronoProgressStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                 ByVal b_ModulNbr As Integer, _
                                                                                      pb_ChronoStatus As Integer) As Integer

Declare Function i_APCI1710_ReadChronoValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                 ByVal b_ModulNbr As Integer, _
                                                                                 ByVal ui_TimeOut As Long, _
                                                                                       pb_ChronoStatus As Integer, _
                                                                                      pul_ChronoValue As Long) As Integer


Declare Function i_APCI1710_ConvertChronoValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                 ByVal b_ModulNbr As Integer, _
                                                                                 ByVal ul_ChronoValue As Long, _
                                                                                      pul_Hour As Long, _
                                                                                       pb_Minute As Integer, _
                                                                                       pb_Second As Integer, _
                                                                                      pui_MilliSecond As Long, _
                                                                                      pui_MicroSecond As Long, _
                                                                                      pui_NanoSecond As Long) As Integer


'****************************************************************************'
'*                      CHRONOMETER DIGITAL OUTPUT FUNCTION                 *'
'****************************************************************************'

Declare Function i_APCI1710_SetChronoChlOn Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                         ByVal b_ModulNbr As Integer, _
                                                                         ByVal b_OutputChannel As Integer) As Integer


Declare Function i_APCI1710_SetChronoChlOff Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                         ByVal b_ModulNbr As Integer, _
                                                                         ByVal b_OutputChannel As Integer) As Integer

'****************************************************************************'
'*                      CHRONOMETER DIGITAL INPUT FUNCTION                  *'
'****************************************************************************'

Declare Function i_APCI1710_ReadChronoChlValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                     ByVal b_ModulNbr As Integer, _
                                                                     ByVal b_InputChannel As Integer, _
                                                                          pb_ChannelStatus As Integer) As Integer

Declare Function i_APCI1710_ReadChronoPortValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                     ByVal b_ModulNbr As Integer, _
                                                                          pb_PortValue As Integer) As Integer

'****************************************************************************'
'*   INP_CPT.C                                                              *'
'****************************************************************************'

Declare Function i_APCI1710_InitPulseEncoder Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                               ByVal b_ModulNbr As Integer, _
                                                                               ByVal b_PulseEncoderNbr As Integer, _
                                                                               ByVal b_InputLevelSelection As Integer, _
                                                                               ByVal b_TriggerOutputAction As Integer, _
                                                                               ByVal ul_StartValue As Long) As Integer

Declare Function i_APCI1710_EnablePulseEncoder Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                ByVal b_ModulNbr As Integer, _
                                                                                ByVal b_PulseEncoderNbr As Integer, _
                                                                                ByVal b_CycleSelection As Integer, _
                                                                                ByVal b_InterruptHandling As Integer) As Integer

Declare Function i_APCI1710_DisablePulseEncoder Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                 ByVal b_ModulNbr As Integer, _
                                                                                 ByVal b_PulseEncoderNbr As Integer) As Integer

'****************************************************************************'
'*                      READ PULSE ENCODER FUNCTIONS                        *'
'****************************************************************************'

Declare Function i_APCI1710_ReadPulseEncoderStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                      ByVal b_ModulNbr As Integer, _
                                                                                      ByVal b_PulseEncoderNbr As Integer, _
                                                                                           pb_Status As Integer) As Integer


Declare Function i_APCI1710_ReadPulseEncoderValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                      ByVal b_ModulNbr As Integer, _
                                                                                      ByVal b_PulseEncoderNbr As Integer, _
                                                                                          pul_ReadValue As Long) As Integer

'****************************************************************************'
'*                      WRITE PULSE ENCODER FUNCTIONS                       *'
'****************************************************************************'

Declare Function i_APCI1710_WritePulseEncoderValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                                      ByVal b_ModulNbr As Integer, _
                                                                                      ByVal b_PulseEncoderNbr As Integer, _
                                                                                      ByVal ul_WriteValue As Long) As Integer

'****************************************************************************'
'*   TOR.C                                                                  *'
'****************************************************************************'

Declare Function i_APCI1710_InitTorCounter Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                  ByVal b_ModulNbr As Integer, _
                                                                  ByVal b_TorCounter As Integer, _
                                                                  ByVal b_PCIInputClock As Integer, _
                                                                  ByVal b_TimingUnity As Integer, _
                                                                  ByVal ul_TimingInterval As Long, _
                                                                       pul_RealTimingInterval As Long) As Integer


Declare Function i_APCI1710_EnableTorCounter Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                  ByVal b_ModulNbr As Integer, _
                                                                  ByVal b_TorCounter As Integer, _
                                                                  ByVal b_InputMode As Integer, _
                                                                  ByVal b_ExternGate As Integer, _
                                                                  ByVal b_CycleMode As Integer, _
                                                                  ByVal b_InterruptEnable As Integer) As Integer


Declare Function i_APCI1710_DisableTorCounter Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                  ByVal b_ModulNbr As Integer, _
                                                                  ByVal b_TorCounter As Integer) As Integer


Declare Function i_APCI1710_GetTorCounterInitialisation Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal b_TorCounter As Integer, _
                                                                            ByVal pb_TimingUnity As Integer, _
                                                                                 pul_TimingInterval As Long, _
                                                                                  pb_InputMode As Integer, _
                                                                                  pb_ExternGate As Integer, _
                                                                                  pb_CycleMode As Integer, _
                                                                                  pb_Enable As Integer, _
                                                                                  pb_InterruptEnable As Integer) As Integer

'****************************************************************************'
'*                      READ TOR COUNTER FUNCTIONS                          *'
'****************************************************************************'

Declare Function i_APCI1710_GetTorCounterProgressStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                             ByVal b_ModulNbr As Integer, _
                                                                             ByVal b_TorCounter As Integer, _
                                                                                  pb_TorCounterStatus As Integer) As Integer

Declare Function i_APCI1710_ReadTorCounterValue Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal b_TorCounter As Integer, _
                                                                    ByVal ui_TimeOut As Long, _
                                                                          pb_TorCounterStatus As Integer, _
                                                                         pul_TorCounterValue As Long) As Integer
                                                                         

'****************************************************************************'
'*   PWM.C                                                                  *'
'****************************************************************************'

Declare Function i_APCI1710_InitPWM Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                            ByVal b_ModulNbr As Integer, _
                                                            ByVal b_PWM As Integer, _
                                                            ByVal b_ClockSelection As Integer, _
                                                            ByVal b_TimingUnit As Integer, _
                                                            ByVal ul_LowTiming As Long, _
                                                            ByVal ul_HighTiming As Long, _
                                                                 pul_RealLowTiming As Long, _
                                                                 pul_RealHighTiming As Long) As Integer

Declare Function i_APCI1710_SetNewPWMTiming Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                ByVal b_ModulNbr As Integer, _
                                                                ByVal b_PWM As Integer, _
                                                                ByVal b_ClockSelection As Integer, _
                                                                ByVal b_TimingUnit As Integer, _
                                                                ByVal ul_LowTiming As Long, _
                                                                ByVal ul_HighTiming As Long) As Integer

Declare Function i_APCI1710_EnablePWM Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                            ByVal b_ModulNbr As Integer, _
                                                            ByVal b_PWM As Integer, _
                                                            ByVal b_StartLevel As Integer, _
                                                            ByVal b_StopMode As Integer, _
                                                            ByVal b_StopLevel As Integer, _
                                                            ByVal b_ExternGate As Integer, _
                                                            ByVal b_InterruptEnable As Integer) As Integer

Declare Function i_APCI1710_DisablePWM Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                            ByVal b_ModulNbr As Integer, _
                                                            ByVal b_PWM As Integer) As Integer

Declare Function i_APCI1710_GetPWMInitialisation Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, ByVal b_ModulNbr As Integer, _
                                                                           ByVal b_PWM As Integer, pb_TimingUnit As Integer, _
                                                                               pul_LowTiming As Long, pul_HighTiming As Long, _
                                                                               pb_StartLevel As Integer, pb_StopMode As Integer, _
                                                                               pb_StopLevel As Integer, pb_ExternGate As Integer, _
                                                                               pb_InterruptEnable As Integer, pb_Enable As Integer) As Integer


Declare Function i_APCI1710_GetPWMStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                   ByVal b_ModulNbr As Integer, _
                                                                   ByVal b_PWM As Integer, _
                                                                        pb_PWMOutputStatus As Integer, _
                                                                        pb_ExternGateStatus As Integer) As Integer

'****************************************************************************'
'*   CDA.C                                                                  *'
'****************************************************************************'

Declare Function i_APCI1710_SetCDAFunctionality Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal b_FunctionalitySelection As Integer) As Integer

Declare Function i_APCI1710_InitCDA Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer, _
                                                                    ByVal ul_Step As Long, _
                                                                    ByVal ul_Multiplier As Long) As Integer

Declare Function i_APCI1710_EnableCDA Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_DisableCDA Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                    ByVal b_ModulNbr As Integer) As Integer

Declare Function i_APCI1710_GetCDAProgressStatus Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                     ByVal b_ModulNbr As Integer, _
                                                                          pb_CDAStatus As Integer, _
                                                                          pb_FIFOStatus As Integer, _
                                                                          pb_Overflow As Integer) As Integer

Declare Function i_APCI1710_ReadCDAMinAndMaxDifference Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                                 pl_MinDifference As Long, _
                                                                                 pl_MaxDifference As Long) As Integer

Declare Function i_APCI1710_ReadCDAArrayFromFIFO Lib "APCI1710.DLL" (ByVal b_BoardHandle As Integer, _
                                                                            ByVal b_ModulNbr As Integer, _
                                                                            ByVal ul_NumberOfElement As Long, _
                                                                                  pl_DifferenceArray As Long) As Integer

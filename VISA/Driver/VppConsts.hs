module VISA.Driver.VppConsts
    ( -- Attribute constants
      viAttrRsrcName
    , viAttrRsrcImplVersion
    , viAttrRsrcLockState
    , viAttrMaxQueueLength
    , viAttrUserData32
    , viAttrFdcChnl
    , viAttrFdcMode
    , viAttrFdcGenSignalEn
    , viAttrFdcUsePair
    , viAttrSendEndEn
    , viAttrTermchar
    , viAttrTmoValue
    , viAttrGpibReaddrEn
    , viAttrIoProt
    , viAttrDmaAllowEn
    , viAttrAsrlBaud
    , viAttrAsrlDataBits
    , viAttrAsrlParity
    , viAttrAsrlStopBits
    , viAttrAsrlFlowCntrl
    , viAttrRdBufOperMode
    , viAttrRdBufSize
    , viAttrWrBufOperMode
    , viAttrWrBufSize
    , viAttrSuppressEndEn
    , viAttrTermcharEn
    , viAttrDestAccessPriv
    , viAttrDestByteOrder
    , viAttrSrcAccessPriv
    , viAttrSrcByteOrder
    , viAttrSrcIncrement
    , viAttrDestIncrement
    , viAttrWinAccessPriv
    , viAttrWinByteOrder
    , viAttrGpibAtnState
    , viAttrGpibAddrState
    , viAttrGpibCicState
    , viAttrGpibNdacState
    , viAttrGpibSrqState
    , viAttrGpibSysCntrlState
    , viAttrGpibHs488CblLen
    , viAttrCmdrLa
    , viAttrVxiDevClass
    , viAttrMainframeLa
    , viAttrManfName
    , viAttrModelName
    , viAttrVxiVmeIntrStatus
    , viAttrVxiTrigStatus
    , viAttrVxiVmeSysfailState
    , viAttrWinBaseAddr32
    , viAttrWinSize32
    , viAttrAsrlAvailNum
    , viAttrMemBase32
    , viAttrAsrlCtsState
    , viAttrAsrlDcdState
    , viAttrAsrlDsrState
    , viAttrAsrlDtrState
    , viAttrAsrlEndIn
    , viAttrAsrlEndOut
    , viAttrAsrlReplaceChar
    , viAttrAsrlRiState
    , viAttrAsrlRtsState
    , viAttrAsrlXonChar
    , viAttrAsrlXoffChar
    , viAttrWinAccess
    , viAttrRmSession
    , viAttrVxiLa
    , viAttrManfId
    , viAttrMemSize32
    , viAttrMemSpace
    , viAttrModelCode
    , viAttrSlot
    , viAttrIntfInstName
    , viAttrImmediateServ
    , viAttrIntfParentNum
    , viAttrRsrcSpecVersion
    , viAttrIntfType
    , viAttrGpibPrimaryAddr
    , viAttrGpibSecondaryAddr
    , viAttrRsrcManfName
    , viAttrRsrcManfId
    , viAttrIntfNum
    , viAttrTrigId
    , viAttrGpibRenState
    , viAttrGpibUnaddrEn
    , viAttrDevStatusByte
    , viAttrFileAppendEn
    , viAttrVxiTrigSupport
    , viAttrTcpipAddr
    , viAttrTcpipHostname
    , viAttrTcpipPort
    , viAttrTcpipDeviceName
    , viAttrTcpipNodelay
    , viAttrTcpipKeepalive
    , viAttr4882Compliant
    , viAttrUsbSerialNum
    , viAttrUsbIntfcNum
    , viAttrUsbProtocol
    , viAttrUsbMaxIntrSize
    , viAttrPxiDevNum
    , viAttrPxiFuncNum
    , viAttrPxiBusNum
    , viAttrPxiChassis
    , viAttrPxiSlotpath
    , viAttrPxiSlotLbusLeft
    , viAttrPxiSlotLbusRight
    , viAttrPxiTrigBus
    , viAttrPxiStarTrigBus
    , viAttrPxiStarTrigLine
    , viAttrPxiSrcTrigBus
    , viAttrPxiDestTrigBus
    , viAttrPxiMemTypeBar0
    , viAttrPxiMemTypeBar1
    , viAttrPxiMemTypeBar2
    , viAttrPxiMemTypeBar3
    , viAttrPxiMemTypeBar4
    , viAttrPxiMemTypeBar5
    , viAttrPxiMemBaseBar032
    , viAttrPxiMemBaseBar132
    , viAttrPxiMemBaseBar232
    , viAttrPxiMemBaseBar332
    , viAttrPxiMemBaseBar432
    , viAttrPxiMemBaseBar532
    , viAttrPxiMemBaseBar064
    , viAttrPxiMemBaseBar164
    , viAttrPxiMemBaseBar264
    , viAttrPxiMemBaseBar364
    , viAttrPxiMemBaseBar464
    , viAttrPxiMemBaseBar564
    , viAttrPxiMemSizeBar032
    , viAttrPxiMemSizeBar132
    , viAttrPxiMemSizeBar232
    , viAttrPxiMemSizeBar332
    , viAttrPxiMemSizeBar432
    , viAttrPxiMemSizeBar532
    , viAttrPxiMemSizeBar064
    , viAttrPxiMemSizeBar164
    , viAttrPxiMemSizeBar264
    , viAttrPxiMemSizeBar364
    , viAttrPxiMemSizeBar464
    , viAttrPxiMemSizeBar564
    , viAttrPxiIsExpress
    , viAttrPxiSlotLwidth
    , viAttrPxiMaxLwidth
    , viAttrPxiActualLwidth
    , viAttrPxiDstarBus
    , viAttrPxiDstarSet
    , viAttrPxiAllowWriteCombine
    , viAttrTcpipHislipOverlapEn
    , viAttrTcpipHislipVersion
    , viAttrTcpipHislipMaxMessageKb
    , viAttrTcpipIsHislip
    , viAttrJobId
    , viAttrEventType
    , viAttrSigpStatusId
    , viAttrRecvTrigId
    , viAttrIntrStatusId
    , viAttrStatus
    , viAttrRetCount32
    , viAttrBuffer
    , viAttrRecvIntrLevel
    , viAttrOperName
    , viAttrGpibRecvCicState
    , viAttrRecvTcpipAddr
    , viAttrUsbRecvIntrSize
    , viAttrUsbRecvIntrData
    , viAttrPxiRecvIntrSeq
    , viAttrPxiRecvIntrData
    , viAttrUserData
    , viAttrRetCount
    , viAttrWinBaseAddr
    , viAttrWinSize
    , viAttrMemBase
    , viAttrMemSize
    , viAttrPxiMemBaseBar0
    , viAttrPxiMemBaseBar1
    , viAttrPxiMemBaseBar2
    , viAttrPxiMemBaseBar3
    , viAttrPxiMemBaseBar4
    , viAttrPxiMemBaseBar5
    , viAttrPxiMemSizeBar0
    , viAttrPxiMemSizeBar1
    , viAttrPxiMemSizeBar2
    , viAttrPxiMemSizeBar3
    , viAttrPxiMemSizeBar4
    , viAttrPxiMemSizeBar5

    -- Event Constants
    , viEventIoCompletion
    , viEventTrig
    , viEventServiceReq
    , viEventClear
    , viEventException
    , viEventGpibCic
    , viEventGpibTalk
    , viEventGpibListen
    , viEventVxiVmeSysfail
    , viEventVxiVmeSysreset
    , viEventVxiSigp
    , viEventVxiVmeIntr
    , viEventPxiIntr
    , viEventTcpipConnect
    , viEventUsbIntr
    , viAllEnabledEvents

    -- Completion and Error Codes
    , viSuccess
    , viSuccessEventEn
    , viSuccessEventDis
    , viSuccessQueueEmpty
    , viSuccessTermChar
    , viSuccessMaxCnt
    , viSuccessDevNpresent
    , viSuccessTrigMapped
    , viSuccessQueueNempty
    , viSuccessNchain
    , viSuccessNestedShared
    , viSuccessNestedExclusive
    , viSuccessSync

    , viWarnQueueOverflow
    , viWarnConfigNloaded
    , viWarnNullObject
    , viWarnNsupAttrState
    , viWarnUnknownStatus
    , viWarnNsupBuf
    , viWarnExtFuncNimpl

    , viErrorSystemError
    , viErrorInvObject
    , viErrorRsrcLocked
    , viErrorInvExpr
    , viErrorRsrcNfound
    , viErrorInvRsrcName
    , viErrorInvAccMode
    , viErrorTmo
    , viErrorClosingFailed
    , viErrorInvDegree
    , viErrorInvJobId
    , viErrorNsupAttr
    , viErrorNsupAttrState
    , viErrorAttrReadonly
    , viErrorInvLockType
    , viErrorInvAccessKey
    , viErrorInvEvent
    , viErrorInvMech
    , viErrorHndlrNinstalled
    , viErrorInvHndlrRef
    , viErrorInvContext
    , viErrorQueueOverflow
    , viErrorNenabled
    , viErrorAbort
    , viErrorRawWrProtViol
    , viErrorRawRdProtViol
    , viErrorOutpProtViol
    , viErrorInpProtViol
    , viErrorBerr
    , viErrorInProgress
    , viErrorInvSetup
    , viErrorQueueError
    , viErrorAlloc
    , viErrorInvMask
    , viErrorIo
    , viErrorInvFmt
    , viErrorNsupFmt
    , viErrorLineInUse
    , viErrorNsupMode
    , viErrorSrqNoccurred
    , viErrorInvSpace
    , viErrorInvOffset
    , viErrorInvWidth
    , viErrorNsupOffset
    , viErrorNsupVarWidth
    , viErrorWindowNmapped
    , viErrorRespPending
    , viErrorNlisteners
    , viErrorNcic
    , viErrorNsysCntlr
    , viErrorNsupOper
    , viErrorIntrPending
    , viErrorAsrlParity
    , viErrorAsrlFraming
    , viErrorAsrlOverrun
    , viErrorTrigNmapped
    , viErrorNsupAlignOffset
    , viErrorUserBuf
    , viErrorRsrcBusy
    , viErrorNsupWidth
    , viErrorInvParameter
    , viErrorInvProt
    , viErrorInvSize
    , viErrorWindowMapped
    , viErrorNimplOper
    , viErrorInvLength
    , viErrorInvMode
    , viErrorSesnNlocked
    , viErrorMemNshared
    , viErrorLibraryNfound
    , viErrorNsupIntr
    , viErrorInvLine
    , viErrorFileAccess
    , viErrorFileIo
    , viErrorNsupLine
    , viErrorNsupMech
    , viErrorIntfNumNconfig
    , viErrorConnLost
    , viErrorMachineNavail
    , viErrorNpermission

    -- Other VISA Constants
    , viNull
    , viFindBuflen

    , viIntfGpib
    , viIntfVxi
    , viIntfGpibVxi
    , viIntfAsrl
    , viIntfPxi
    , viIntfTcpip
    , viIntfUsb

    , viProtNormal
    , viProtFdc
    , viProtHs488
    , viProt4882Strs
    , viProtUsbtmcVendor

    , viFdcNormal
    , viFdcStream

    , viLocalSpace

    , viA16Space
    , viA24Space
    , viA32Space
    , viA64Space

    , viPxiAllocSpace
    , viPxiCfgSpace
    , viPxiBar0Space
    , viPxiBar1Space
    , viPxiBar2Space
    , viPxiBar3Space
    , viPxiBar4Space
    , viPxiBar5Space

    , viOpaqueSpace

    , viUnknownLa
    , viUnknownSlot
    , viUnknownLevel
    , viUnknownChassis

    , viQueue

    , viHndlr
    , viSuspendHndlr
    , viAllMech
    , viAnyHndlr

    , viTrigAll
    , viTrigSw
    , viTrigTtl0
    , viTrigTtl1
    , viTrigTtl2
    , viTrigTtl3
    , viTrigTtl4
    , viTrigTtl5
    , viTrigTtl6
    , viTrigTtl7
    , viTrigEcl0
    , viTrigEcl1
    , viTrigEcl2
    , viTrigEcl3
    , viTrigEcl4
    , viTrigEcl5
    , viTrigStarSlot1
    , viTrigStarSlot2
    , viTrigStarSlot3
    , viTrigStarSlot4
    , viTrigStarSlot5
    , viTrigStarSlot6
    , viTrigStarSlot7
    , viTrigStarSlot8
    , viTrigStarSlot9
    , viTrigStarSlot10
    , viTrigStarSlot11
    , viTrigStarSlot12
    , viTrigStarInstr
    , viTrigPanelIn
    , viTrigPanelOut
    , viTrigStarVxi0
    , viTrigStarVxi1
    , viTrigStarVxi2
    , viTrigProtDefault
    , viTrigProtOn
    , viTrigProtOff
    , viTrigProtSync
    , viTrigProtReserve
    , viTrigProtUnreserve

    , viReadBuf
    , viWriteBuf
    , viReadBufDiscard
    , viWriteBufDiscard

    , viIoInBuf
    , viIoOutBuf
    , viIoInBufDiscard
    , viIoOutBufDiscard

    , viFlushOnAccess
    , viFlushWhenFull
    , viFlushDisable

    , viNmapped
    , viUseOpers

    , viDerefAddr
    , viDerefAddrByteSwap

    , viTmoImmediate
    , viTmoInfinite

    , viNoLock
    , viExclusiveLock
    , viSharedLock

    , viLoadConfig
    , viNoSecAddr

    , viAsrlParNone
    , viAsrlParOdd
    , viAsrlParEven
    , viAsrlParMark
    , viAsrlParSpace
    , viAsrlStopOne
    , viAsrlStopOne5
    , viAsrlStopTwo
    , viAsrlFlowNone
    , viAsrlFlowXonXoff
    , viAsrlFlowRtsCts
    , viAsrlFlowDtrDsr
    , viAsrlEndNone
    , viAsrlEndLastBit
    , viAsrlEndTermchar
    , viAsrlEndBreak

    , viStateAsserted
    , viStateUnasserted
    , viStateUnknown

    , viBigEndian
    , viLittleEndian

    , viDataPriv
    , viDataNpriv

    , viProgPriv
    , viProgNpriv

    , viBlckPriv
    , viBlckNpriv

    , viD64Priv
    , viD64Npriv
    , viD642evme
    , viD64Sst160
    , viD64Sst267
    , viD64Sst320

    , viWidth8
    , viWidth16
    , viWidth32
    , viWidth64

    , viGpibRenDeassert
    , viGpibRenAssert
    , viGpibRenDeassertGtl
    , viGpibRenAssertAddress
    , viGpibRenAssertLlo
    , viGpibRenAssertAddressLlo
    , viGpibRenAddressGtl

    , viGpibAtnDeassert
    , viGpibAtnAssert
    , viGpibAtnDeassertHandshake
    , viGpibAtnAssertImmediate

    , viGpibHs488Disabled
    , viGpibHs488Nimpl

    , viGpibUnaddressed
    , viGpibTalker
    , viGpibListener

    , viVxiCmd16
    , viVxiCmd16Resp16
    , viVxiResp16
    , viVxiCmd32
    , viVxiCmd32Resp16
    , viVxiCmd32Resp32
    , viVxiResp32

    , viAssertSignal
    , viAssertUseAssigned
    , viAssertIrq1
    , viAssertIrq2
    , viAssertIrq3
    , viAssertIrq4
    , viAssertIrq5
    , viAssertIrq6
    , viAssertIrq7

    , viUtilAssertSysreset
    , viUtilAssertSysfail
    , viUtilDeassertSysfail

    , viVxiClassMemory
    , viVxiClassExtended
    , viVxiClassMessage
    , viVxiClassRegister
    , viVxiClassOther

    , viPxiAddrNone
    , viPxiAddrMem
    , viPxiAddrIo
    , viPxiAddrCfg

    , viTrigUnknown

    , viPxiLbusUnknown
    , viPxiLbusNone
    , viPxiLbusStarTrigBus0
    , viPxiLbusStarTrigBus1
    , viPxiLbusStarTrigBus2
    , viPxiLbusStarTrigBus3
    , viPxiLbusStarTrigBus4
    , viPxiLbusStarTrigBus5
    , viPxiLbusStarTrigBus6
    , viPxiLbusStarTrigBus7
    , viPxiLbusStarTrigBus8
    , viPxiLbusStarTrigBus9
    , viPxiStarTrigController

    -- National Instruments
    , viIntfRio
    , viIntfFirewire
    , viAttrSyncMxiAllowEn

    -- Misc
    , viAttrFirewireDestUpperOffset
    , viAttrFirewireSrcUpperOffset
    , viAttrFirewireWinUpperOffset
    , viAttrFirewireVendorId
    , viAttrFirewireLowerChipId
    , viAttrFirewireUpperChipId
    , viFirewireDfltSpace
    ) where


{- Attribute Types -}
viAttrRsrcName,
    viAttrRsrcImplVersion,
    viAttrRsrcLockState,
    viAttrMaxQueueLength,
    viAttrUserData32,
    viAttrFdcChnl,
    viAttrFdcMode,
    viAttrFdcGenSignalEn,
    viAttrFdcUsePair,
    viAttrSendEndEn,
    viAttrTermchar,
    viAttrTmoValue,
    viAttrGpibReaddrEn,
    viAttrIoProt,
    viAttrDmaAllowEn,
    viAttrAsrlBaud,
    viAttrAsrlDataBits,
    viAttrAsrlParity,
    viAttrAsrlStopBits,
    viAttrAsrlFlowCntrl,
    viAttrRdBufOperMode,
    viAttrRdBufSize,
    viAttrWrBufOperMode,
    viAttrWrBufSize,
    viAttrSuppressEndEn,
    viAttrTermcharEn,
    viAttrDestAccessPriv,
    viAttrDestByteOrder,
    viAttrSrcAccessPriv,
    viAttrSrcByteOrder,
    viAttrSrcIncrement,
    viAttrDestIncrement,
    viAttrWinAccessPriv,
    viAttrWinByteOrder,
    viAttrGpibAtnState,
    viAttrGpibAddrState,
    viAttrGpibCicState,
    viAttrGpibNdacState,
    viAttrGpibSrqState,
    viAttrGpibSysCntrlState,
    viAttrGpibHs488CblLen,
    viAttrCmdrLa,
    viAttrVxiDevClass,
    viAttrMainframeLa,
    viAttrManfName,
    viAttrModelName,
    viAttrVxiVmeIntrStatus,
    viAttrVxiTrigStatus,
    viAttrVxiVmeSysfailState,
    viAttrWinBaseAddr32,
    viAttrWinSize32,
    viAttrAsrlAvailNum,
    viAttrMemBase32,
    viAttrAsrlCtsState,
    viAttrAsrlDcdState,
    viAttrAsrlDsrState,
    viAttrAsrlDtrState,
    viAttrAsrlEndIn,
    viAttrAsrlEndOut,
    viAttrAsrlReplaceChar,
    viAttrAsrlRiState,
    viAttrAsrlRtsState,
    viAttrAsrlXonChar,
    viAttrAsrlXoffChar,
    viAttrWinAccess,
    viAttrRmSession,
    viAttrVxiLa,
    viAttrManfId,
    viAttrMemSize32,
    viAttrMemSpace,
    viAttrModelCode,
    viAttrSlot,
    viAttrIntfInstName,
    viAttrImmediateServ,
    viAttrIntfParentNum,
    viAttrRsrcSpecVersion,
    viAttrIntfType,
    viAttrGpibPrimaryAddr,
    viAttrGpibSecondaryAddr,
    viAttrRsrcManfName,
    viAttrRsrcManfId,
    viAttrIntfNum,
    viAttrTrigId,
    viAttrGpibRenState,
    viAttrGpibUnaddrEn,
    viAttrDevStatusByte,
    viAttrFileAppendEn,
    viAttrVxiTrigSupport,
    viAttrTcpipAddr,
    viAttrTcpipHostname,
    viAttrTcpipPort,
    viAttrTcpipDeviceName,
    viAttrTcpipNodelay,
    viAttrTcpipKeepalive,
    viAttr4882Compliant,
    viAttrUsbSerialNum,
    viAttrUsbIntfcNum,
    viAttrUsbProtocol,
    viAttrUsbMaxIntrSize,
    viAttrPxiDevNum,
    viAttrPxiFuncNum,
    viAttrPxiBusNum,
    viAttrPxiChassis,
    viAttrPxiSlotpath,
    viAttrPxiSlotLbusLeft,
    viAttrPxiSlotLbusRight,
    viAttrPxiTrigBus,
    viAttrPxiStarTrigBus,
    viAttrPxiStarTrigLine,
    viAttrPxiSrcTrigBus,
    viAttrPxiDestTrigBus,
    viAttrPxiMemTypeBar0,
    viAttrPxiMemTypeBar1,
    viAttrPxiMemTypeBar2,
    viAttrPxiMemTypeBar3,
    viAttrPxiMemTypeBar4,
    viAttrPxiMemTypeBar5,
    viAttrPxiMemBaseBar032,
    viAttrPxiMemBaseBar132,
    viAttrPxiMemBaseBar232,
    viAttrPxiMemBaseBar332,
    viAttrPxiMemBaseBar432,
    viAttrPxiMemBaseBar532,
    viAttrPxiMemBaseBar064,
    viAttrPxiMemBaseBar164,
    viAttrPxiMemBaseBar264,
    viAttrPxiMemBaseBar364,
    viAttrPxiMemBaseBar464,
    viAttrPxiMemBaseBar564,
    viAttrPxiMemSizeBar032,
    viAttrPxiMemSizeBar132,
    viAttrPxiMemSizeBar232,
    viAttrPxiMemSizeBar332,
    viAttrPxiMemSizeBar432,
    viAttrPxiMemSizeBar532,
    viAttrPxiMemSizeBar064,
    viAttrPxiMemSizeBar164,
    viAttrPxiMemSizeBar264,
    viAttrPxiMemSizeBar364,
    viAttrPxiMemSizeBar464,
    viAttrPxiMemSizeBar564,
    viAttrPxiIsExpress,
    viAttrPxiSlotLwidth,
    viAttrPxiMaxLwidth,
    viAttrPxiActualLwidth,
    viAttrPxiDstarBus,
    viAttrPxiDstarSet,
    viAttrPxiAllowWriteCombine,
    viAttrTcpipHislipOverlapEn,
    viAttrTcpipHislipVersion,
    viAttrTcpipHislipMaxMessageKb,
    viAttrTcpipIsHislip,
    viAttrJobId,
    viAttrEventType,
    viAttrSigpStatusId,
    viAttrRecvTrigId,
    viAttrIntrStatusId,
    viAttrStatus,
    viAttrRetCount32,
    viAttrBuffer,
    viAttrRecvIntrLevel,
    viAttrOperName,
    viAttrGpibRecvCicState,
    viAttrRecvTcpipAddr,
    viAttrUsbRecvIntrSize,
    viAttrUsbRecvIntrData,
    viAttrPxiRecvIntrSeq,
    viAttrPxiRecvIntrData,
    viAttrUserData,
    viAttrRetCount,
    viAttrWinBaseAddr,
    viAttrWinSize,
    viAttrMemBase,
    viAttrMemSize,
    viAttrPxiMemBaseBar0,
    viAttrPxiMemBaseBar1,
    viAttrPxiMemBaseBar2,
    viAttrPxiMemBaseBar3,
    viAttrPxiMemBaseBar4,
    viAttrPxiMemBaseBar5,
    viAttrPxiMemSizeBar0,
    viAttrPxiMemSizeBar1,
    viAttrPxiMemSizeBar2,
    viAttrPxiMemSizeBar3,
    viAttrPxiMemSizeBar4,
    viAttrPxiMemSizeBar5 :: Integral a => a
viAttrRsrcName                = 0xBFFF0002
viAttrRsrcImplVersion         = 0x3FFF0003
viAttrRsrcLockState           = 0x3FFF0004
viAttrMaxQueueLength          = 0x3FFF0005
viAttrUserData32              = 0x3FFF0007
viAttrFdcChnl                 = 0x3FFF000D
viAttrFdcMode                 = 0x3FFF000F
viAttrFdcGenSignalEn          = 0x3FFF0011
viAttrFdcUsePair              = 0x3FFF0013
viAttrSendEndEn               = 0x3FFF0016
viAttrTermchar                = 0x3FFF0018
viAttrTmoValue                = 0x3FFF001A
viAttrGpibReaddrEn            = 0x3FFF001B
viAttrIoProt                  = 0x3FFF001C
viAttrDmaAllowEn              = 0x3FFF001E
viAttrAsrlBaud                = 0x3FFF0021
viAttrAsrlDataBits            = 0x3FFF0022
viAttrAsrlParity              = 0x3FFF0023
viAttrAsrlStopBits            = 0x3FFF0024
viAttrAsrlFlowCntrl           = 0x3FFF0025
viAttrRdBufOperMode           = 0x3FFF002A
viAttrRdBufSize               = 0x3FFF002B
viAttrWrBufOperMode           = 0x3FFF002D
viAttrWrBufSize               = 0x3FFF002E
viAttrSuppressEndEn           = 0x3FFF0036
viAttrTermcharEn              = 0x3FFF0038
viAttrDestAccessPriv          = 0x3FFF0039
viAttrDestByteOrder           = 0x3FFF003A
viAttrSrcAccessPriv           = 0x3FFF003C
viAttrSrcByteOrder            = 0x3FFF003D
viAttrSrcIncrement            = 0x3FFF0040
viAttrDestIncrement           = 0x3FFF0041
viAttrWinAccessPriv           = 0x3FFF0045
viAttrWinByteOrder            = 0x3FFF0047
viAttrGpibAtnState            = 0x3FFF0057
viAttrGpibAddrState           = 0x3FFF005C
viAttrGpibCicState            = 0x3FFF005E
viAttrGpibNdacState           = 0x3FFF0062
viAttrGpibSrqState            = 0x3FFF0067
viAttrGpibSysCntrlState       = 0x3FFF0068
viAttrGpibHs488CblLen         = 0x3FFF0069
viAttrCmdrLa                  = 0x3FFF006B
viAttrVxiDevClass             = 0x3FFF006C
viAttrMainframeLa             = 0x3FFF0070
viAttrManfName                = 0xBFFF0072
viAttrModelName               = 0xBFFF0077
viAttrVxiVmeIntrStatus        = 0x3FFF008B
viAttrVxiTrigStatus           = 0x3FFF008D
viAttrVxiVmeSysfailState      = 0x3FFF0094
viAttrWinBaseAddr32           = 0x3FFF0098
viAttrWinSize32               = 0x3FFF009A
viAttrAsrlAvailNum            = 0x3FFF00AC
viAttrMemBase32               = 0x3FFF00AD
viAttrAsrlCtsState            = 0x3FFF00AE
viAttrAsrlDcdState            = 0x3FFF00AF
viAttrAsrlDsrState            = 0x3FFF00B1
viAttrAsrlDtrState            = 0x3FFF00B2
viAttrAsrlEndIn               = 0x3FFF00B3
viAttrAsrlEndOut              = 0x3FFF00B4
viAttrAsrlReplaceChar         = 0x3FFF00BE
viAttrAsrlRiState             = 0x3FFF00BF
viAttrAsrlRtsState            = 0x3FFF00C0
viAttrAsrlXonChar             = 0x3FFF00C1
viAttrAsrlXoffChar            = 0x3FFF00C2
viAttrWinAccess               = 0x3FFF00C3
viAttrRmSession               = 0x3FFF00C4
viAttrVxiLa                   = 0x3FFF00D5
viAttrManfId                  = 0x3FFF00D9
viAttrMemSize32               = 0x3FFF00DD
viAttrMemSpace                = 0x3FFF00DE
viAttrModelCode               = 0x3FFF00DF
viAttrSlot                    = 0x3FFF00E8
viAttrIntfInstName            = 0xBFFF00E9
viAttrImmediateServ           = 0x3FFF0100
viAttrIntfParentNum           = 0x3FFF0101
viAttrRsrcSpecVersion         = 0x3FFF0170
viAttrIntfType                = 0x3FFF0171
viAttrGpibPrimaryAddr         = 0x3FFF0172
viAttrGpibSecondaryAddr       = 0x3FFF0173
viAttrRsrcManfName            = 0xBFFF0174
viAttrRsrcManfId              = 0x3FFF0175
viAttrIntfNum                 = 0x3FFF0176
viAttrTrigId                  = 0x3FFF0177
viAttrGpibRenState            = 0x3FFF0181
viAttrGpibUnaddrEn            = 0x3FFF0184
viAttrDevStatusByte           = 0x3FFF0189
viAttrFileAppendEn            = 0x3FFF0192
viAttrVxiTrigSupport          = 0x3FFF0194
viAttrTcpipAddr               = 0xBFFF0195
viAttrTcpipHostname           = 0xBFFF0196
viAttrTcpipPort               = 0x3FFF0197
viAttrTcpipDeviceName         = 0xBFFF0199
viAttrTcpipNodelay            = 0x3FFF019A
viAttrTcpipKeepalive          = 0x3FFF019B
viAttr4882Compliant           = 0x3FFF019F
viAttrUsbSerialNum            = 0xBFFF01A0
viAttrUsbIntfcNum             = 0x3FFF01A1
viAttrUsbProtocol             = 0x3FFF01A7
viAttrUsbMaxIntrSize          = 0x3FFF01AF
viAttrPxiDevNum               = 0x3FFF0201
viAttrPxiFuncNum              = 0x3FFF0202
viAttrPxiBusNum               = 0x3FFF0205
viAttrPxiChassis              = 0x3FFF0206
viAttrPxiSlotpath             = 0xBFFF0207
viAttrPxiSlotLbusLeft         = 0x3FFF0208
viAttrPxiSlotLbusRight        = 0x3FFF0209
viAttrPxiTrigBus              = 0x3FFF020A
viAttrPxiStarTrigBus          = 0x3FFF020B
viAttrPxiStarTrigLine         = 0x3FFF020C
viAttrPxiSrcTrigBus           = 0x3FFF020D
viAttrPxiDestTrigBus          = 0x3FFF020E
viAttrPxiMemTypeBar0          = 0x3FFF0211
viAttrPxiMemTypeBar1          = 0x3FFF0212
viAttrPxiMemTypeBar2          = 0x3FFF0213
viAttrPxiMemTypeBar3          = 0x3FFF0214
viAttrPxiMemTypeBar4          = 0x3FFF0215
viAttrPxiMemTypeBar5          = 0x3FFF0216
viAttrPxiMemBaseBar032        = 0x3FFF0221
viAttrPxiMemBaseBar132        = 0x3FFF0222
viAttrPxiMemBaseBar232        = 0x3FFF0223
viAttrPxiMemBaseBar332        = 0x3FFF0224
viAttrPxiMemBaseBar432        = 0x3FFF0225
viAttrPxiMemBaseBar532        = 0x3FFF0226
viAttrPxiMemBaseBar064        = 0x3FFF0228
viAttrPxiMemBaseBar164        = 0x3FFF0229
viAttrPxiMemBaseBar264        = 0x3FFF022A
viAttrPxiMemBaseBar364        = 0x3FFF022B
viAttrPxiMemBaseBar464        = 0x3FFF022C
viAttrPxiMemBaseBar564        = 0x3FFF022D
viAttrPxiMemSizeBar032        = 0x3FFF0231
viAttrPxiMemSizeBar132        = 0x3FFF0232
viAttrPxiMemSizeBar232        = 0x3FFF0233
viAttrPxiMemSizeBar332        = 0x3FFF0234
viAttrPxiMemSizeBar432        = 0x3FFF0235
viAttrPxiMemSizeBar532        = 0x3FFF0236
viAttrPxiMemSizeBar064        = 0x3FFF0238
viAttrPxiMemSizeBar164        = 0x3FFF0239
viAttrPxiMemSizeBar264        = 0x3FFF023A
viAttrPxiMemSizeBar364        = 0x3FFF023B
viAttrPxiMemSizeBar464        = 0x3FFF023C
viAttrPxiMemSizeBar564        = 0x3FFF023D
viAttrPxiIsExpress            = 0x3FFF0240
viAttrPxiSlotLwidth           = 0x3FFF0241
viAttrPxiMaxLwidth            = 0x3FFF0242
viAttrPxiActualLwidth         = 0x3FFF0243
viAttrPxiDstarBus             = 0x3FFF0244
viAttrPxiDstarSet             = 0x3FFF0245
viAttrPxiAllowWriteCombine    = 0x3FFF0246
viAttrTcpipHislipOverlapEn    = 0x3FFF0300
viAttrTcpipHislipVersion      = 0x3FFF0301
viAttrTcpipHislipMaxMessageKb = 0x3FFF0302
viAttrTcpipIsHislip           = 0x3FFF0303
viAttrJobId                   = 0x3FFF4006
viAttrEventType               = 0x3FFF4010
viAttrSigpStatusId            = 0x3FFF4011
viAttrRecvTrigId              = 0x3FFF4012
viAttrIntrStatusId            = 0x3FFF4023
viAttrStatus                  = 0x3FFF4025
viAttrRetCount32              = 0x3FFF4026
viAttrBuffer                  = 0x3FFF4027
viAttrRecvIntrLevel           = 0x3FFF4041
viAttrOperName                = 0xBFFF4042
viAttrGpibRecvCicState        = 0x3FFF4193
viAttrRecvTcpipAddr           = 0xBFFF4198
viAttrUsbRecvIntrSize         = 0x3FFF41B0
viAttrUsbRecvIntrData         = 0xBFFF41B1
viAttrPxiRecvIntrSeq          = 0x3FFF4240
viAttrPxiRecvIntrData         = 0x3FFF4241
viAttrUserData                = viAttrUserData32
viAttrRetCount                = viAttrRetCount32
viAttrWinBaseAddr             = viAttrWinBaseAddr32
viAttrWinSize                 = viAttrWinSize32
viAttrMemBase                 = viAttrMemBase32
viAttrMemSize                 = viAttrMemSize32
viAttrPxiMemBaseBar0          = viAttrPxiMemBaseBar032
viAttrPxiMemBaseBar1          = viAttrPxiMemBaseBar132
viAttrPxiMemBaseBar2          = viAttrPxiMemBaseBar232
viAttrPxiMemBaseBar3          = viAttrPxiMemBaseBar332
viAttrPxiMemBaseBar4          = viAttrPxiMemBaseBar432
viAttrPxiMemBaseBar5          = viAttrPxiMemBaseBar532
viAttrPxiMemSizeBar0          = viAttrPxiMemSizeBar032
viAttrPxiMemSizeBar1          = viAttrPxiMemSizeBar132
viAttrPxiMemSizeBar2          = viAttrPxiMemSizeBar232
viAttrPxiMemSizeBar3          = viAttrPxiMemSizeBar332
viAttrPxiMemSizeBar4          = viAttrPxiMemSizeBar432
viAttrPxiMemSizeBar5          = viAttrPxiMemSizeBar532

{- Event Types -}

viEventIoCompletion,
    viEventTrig,
    viEventServiceReq,
    viEventClear,
    viEventException,
    viEventGpibCic,
    viEventGpibTalk,
    viEventGpibListen,
    viEventVxiVmeSysfail,
    viEventVxiVmeSysreset,
    viEventVxiSigp,
    viEventVxiVmeIntr,
    viEventPxiIntr,
    viEventTcpipConnect,
    viEventUsbIntr,
    viAllEnabledEvents :: Integral a => a
viEventIoCompletion   = 0x3FFF2009
viEventTrig           = 0xBFFF200A
viEventServiceReq     = 0x3FFF200B
viEventClear          = 0x3FFF200D
viEventException      = 0xBFFF200E
viEventGpibCic        = 0x3FFF2012
viEventGpibTalk       = 0x3FFF2013
viEventGpibListen     = 0x3FFF2014
viEventVxiVmeSysfail  = 0x3FFF201D
viEventVxiVmeSysreset = 0x3FFF201E
viEventVxiSigp        = 0x3FFF2020
viEventVxiVmeIntr     = 0xBFFF2021
viEventPxiIntr        = 0x3FFF2022
viEventTcpipConnect   = 0x3FFF2036
viEventUsbIntr        = 0x3FFF2037

viAllEnabledEvents    = 0x3FFF7FFF


{- Completion and Error Codes -}
_VI_ERROR :: Integral a => a
_VI_ERROR = -0x80000000

viSuccess,
    viSuccessEventEn,
    viSuccessEventDis,
    viSuccessQueueEmpty,
    viSuccessTermChar,
    viSuccessMaxCnt,
    viSuccessDevNpresent,
    viSuccessTrigMapped,
    viSuccessQueueNempty,
    viSuccessNchain,
    viSuccessNestedShared,
    viSuccessNestedExclusive,
    viSuccessSync :: Integral a => a
viSuccess                = 0x00000000
viSuccessEventEn         = 0x3FFF0002
viSuccessEventDis        = 0x3FFF0003
viSuccessQueueEmpty      = 0x3FFF0004
viSuccessTermChar        = 0x3FFF0005
viSuccessMaxCnt          = 0x3FFF0006
viSuccessDevNpresent     = 0x3FFF007D
viSuccessTrigMapped      = 0x3FFF007E
viSuccessQueueNempty     = 0x3FFF0080
viSuccessNchain          = 0x3FFF0098
viSuccessNestedShared    = 0x3FFF0099
viSuccessNestedExclusive = 0x3FFF009A
viSuccessSync            = 0x3FFF009B


viWarnQueueOverflow,
    viWarnConfigNloaded,
    viWarnNullObject,
    viWarnNsupAttrState,
    viWarnUnknownStatus,
    viWarnNsupBuf,
    viWarnExtFuncNimpl :: Integral a => a
viWarnQueueOverflow = 0x3FFF000C
viWarnConfigNloaded = 0x3FFF0077
viWarnNullObject    = 0x3FFF0082
viWarnNsupAttrState = 0x3FFF0084
viWarnUnknownStatus = 0x3FFF0085
viWarnNsupBuf       = 0x3FFF0088
viWarnExtFuncNimpl  = 0x3FFF00A9

viErrorSystemError,
    viErrorInvObject,
    viErrorRsrcLocked,
    viErrorInvExpr,
    viErrorRsrcNfound,
    viErrorInvRsrcName,
    viErrorInvAccMode,
    viErrorTmo,
    viErrorClosingFailed,
    viErrorInvDegree,
    viErrorInvJobId,
    viErrorNsupAttr,
    viErrorNsupAttrState,
    viErrorAttrReadonly,
    viErrorInvLockType,
    viErrorInvAccessKey,
    viErrorInvEvent,
    viErrorInvMech,
    viErrorHndlrNinstalled,
    viErrorInvHndlrRef,
    viErrorInvContext,
    viErrorQueueOverflow,
    viErrorNenabled,
    viErrorAbort,
    viErrorRawWrProtViol,
    viErrorRawRdProtViol,
    viErrorOutpProtViol,
    viErrorInpProtViol,
    viErrorBerr,
    viErrorInProgress,
    viErrorInvSetup,
    viErrorQueueError,
    viErrorAlloc,
    viErrorInvMask,
    viErrorIo,
    viErrorInvFmt,
    viErrorNsupFmt,
    viErrorLineInUse,
    viErrorNsupMode,
    viErrorSrqNoccurred,
    viErrorInvSpace,
    viErrorInvOffset,
    viErrorInvWidth,
    viErrorNsupOffset,
    viErrorNsupVarWidth,
    viErrorWindowNmapped,
    viErrorRespPending,
    viErrorNlisteners,
    viErrorNcic,
    viErrorNsysCntlr,
    viErrorNsupOper,
    viErrorIntrPending,
    viErrorAsrlParity,
    viErrorAsrlFraming,
    viErrorAsrlOverrun,
    viErrorTrigNmapped,
    viErrorNsupAlignOffset,
    viErrorUserBuf,
    viErrorRsrcBusy,
    viErrorNsupWidth,
    viErrorInvParameter,
    viErrorInvProt,
    viErrorInvSize,
    viErrorWindowMapped,
    viErrorNimplOper,
    viErrorInvLength,
    viErrorInvMode,
    viErrorSesnNlocked,
    viErrorMemNshared,
    viErrorLibraryNfound,
    viErrorNsupIntr,
    viErrorInvLine,
    viErrorFileAccess,
    viErrorFileIo,
    viErrorNsupLine,
    viErrorNsupMech,
    viErrorIntfNumNconfig,
    viErrorConnLost,
    viErrorMachineNavail,
    viErrorNpermission :: Integral a => a
viErrorSystemError     = _VI_ERROR + 0x3FFF0000
viErrorInvObject       = _VI_ERROR + 0x3FFF000E
viErrorRsrcLocked      = _VI_ERROR + 0x3FFF000F
viErrorInvExpr         = _VI_ERROR + 0x3FFF0010
viErrorRsrcNfound      = _VI_ERROR + 0x3FFF0011
viErrorInvRsrcName     = _VI_ERROR + 0x3FFF0012
viErrorInvAccMode      = _VI_ERROR + 0x3FFF0013
viErrorTmo             = _VI_ERROR + 0x3FFF0015
viErrorClosingFailed   = _VI_ERROR + 0x3FFF0016
viErrorInvDegree       = _VI_ERROR + 0x3FFF001B
viErrorInvJobId        = _VI_ERROR + 0x3FFF001C
viErrorNsupAttr        = _VI_ERROR + 0x3FFF001D
viErrorNsupAttrState   = _VI_ERROR + 0x3FFF001E
viErrorAttrReadonly    = _VI_ERROR + 0x3FFF001F
viErrorInvLockType     = _VI_ERROR + 0x3FFF0020
viErrorInvAccessKey    = _VI_ERROR + 0x3FFF0021
viErrorInvEvent        = _VI_ERROR + 0x3FFF0026
viErrorInvMech         = _VI_ERROR + 0x3FFF0027
viErrorHndlrNinstalled = _VI_ERROR + 0x3FFF0028
viErrorInvHndlrRef     = _VI_ERROR + 0x3FFF0029
viErrorInvContext      = _VI_ERROR + 0x3FFF002A
viErrorQueueOverflow   = _VI_ERROR + 0x3FFF002D
viErrorNenabled        = _VI_ERROR + 0x3FFF002F
viErrorAbort           = _VI_ERROR + 0x3FFF0030
viErrorRawWrProtViol   = _VI_ERROR + 0x3FFF0034
viErrorRawRdProtViol   = _VI_ERROR + 0x3FFF0035
viErrorOutpProtViol    = _VI_ERROR + 0x3FFF0036
viErrorInpProtViol     = _VI_ERROR + 0x3FFF0037
viErrorBerr            = _VI_ERROR + 0x3FFF0038
viErrorInProgress      = _VI_ERROR + 0x3FFF0039
viErrorInvSetup        = _VI_ERROR + 0x3FFF003A
viErrorQueueError      = _VI_ERROR + 0x3FFF003B
viErrorAlloc           = _VI_ERROR + 0x3FFF003C
viErrorInvMask         = _VI_ERROR + 0x3FFF003D
viErrorIo              = _VI_ERROR + 0x3FFF003E
viErrorInvFmt          = _VI_ERROR + 0x3FFF003F
viErrorNsupFmt         = _VI_ERROR + 0x3FFF0041
viErrorLineInUse       = _VI_ERROR + 0x3FFF0042
viErrorNsupMode        = _VI_ERROR + 0x3FFF0046
viErrorSrqNoccurred    = _VI_ERROR + 0x3FFF004A
viErrorInvSpace        = _VI_ERROR + 0x3FFF004E
viErrorInvOffset       = _VI_ERROR + 0x3FFF0051
viErrorInvWidth        = _VI_ERROR + 0x3FFF0052
viErrorNsupOffset      = _VI_ERROR + 0x3FFF0054
viErrorNsupVarWidth    = _VI_ERROR + 0x3FFF0055
viErrorWindowNmapped   = _VI_ERROR + 0x3FFF0057
viErrorRespPending     = _VI_ERROR + 0x3FFF0059
viErrorNlisteners      = _VI_ERROR + 0x3FFF005F
viErrorNcic            = _VI_ERROR + 0x3FFF0060
viErrorNsysCntlr       = _VI_ERROR + 0x3FFF0061
viErrorNsupOper        = _VI_ERROR + 0x3FFF0067
viErrorIntrPending     = _VI_ERROR + 0x3FFF0068
viErrorAsrlParity      = _VI_ERROR + 0x3FFF006A
viErrorAsrlFraming     = _VI_ERROR + 0x3FFF006B
viErrorAsrlOverrun     = _VI_ERROR + 0x3FFF006C
viErrorTrigNmapped     = _VI_ERROR + 0x3FFF006E
viErrorNsupAlignOffset = _VI_ERROR + 0x3FFF0070
viErrorUserBuf         = _VI_ERROR + 0x3FFF0071
viErrorRsrcBusy        = _VI_ERROR + 0x3FFF0072
viErrorNsupWidth       = _VI_ERROR + 0x3FFF0076
viErrorInvParameter    = _VI_ERROR + 0x3FFF0078
viErrorInvProt         = _VI_ERROR + 0x3FFF0079
viErrorInvSize         = _VI_ERROR + 0x3FFF007B
viErrorWindowMapped    = _VI_ERROR + 0x3FFF0080
viErrorNimplOper       = _VI_ERROR + 0x3FFF0081
viErrorInvLength       = _VI_ERROR + 0x3FFF0083
viErrorInvMode         = _VI_ERROR + 0x3FFF0091
viErrorSesnNlocked     = _VI_ERROR + 0x3FFF009C
viErrorMemNshared      = _VI_ERROR + 0x3FFF009D
viErrorLibraryNfound   = _VI_ERROR + 0x3FFF009E
viErrorNsupIntr        = _VI_ERROR + 0x3FFF009F
viErrorInvLine         = _VI_ERROR + 0x3FFF00A0
viErrorFileAccess      = _VI_ERROR + 0x3FFF00A1
viErrorFileIo          = _VI_ERROR + 0x3FFF00A2
viErrorNsupLine        = _VI_ERROR + 0x3FFF00A3
viErrorNsupMech        = _VI_ERROR + 0x3FFF00A4
viErrorIntfNumNconfig  = _VI_ERROR + 0x3FFF00A5
viErrorConnLost        = _VI_ERROR + 0x3FFF00A6
viErrorMachineNavail   = _VI_ERROR + 0x3FFF00A7
viErrorNpermission     = _VI_ERROR + 0x3FFF00A8


{- Other VISA Definitions -}
viNull :: Integral a => a
viNull = 0

viFindBuflen :: Integral a => a
viFindBuflen = 256

viIntfGpib,
    viIntfVxi,
    viIntfGpibVxi,
    viIntfAsrl,
    viIntfPxi,
    viIntfTcpip,
    viIntfUsb :: Integral a => a
viIntfGpib    = 1
viIntfVxi     = 2
viIntfGpibVxi = 3
viIntfAsrl    = 4
viIntfPxi     = 5
viIntfTcpip   = 6
viIntfUsb     = 7

viProtNormal,
    viProtFdc,
    viProtHs488,
    viProt4882Strs,
    viProtUsbtmcVendor :: Integral a => a
viProtNormal       = 1
viProtFdc          = 2
viProtHs488        = 3
viProt4882Strs     = 4
viProtUsbtmcVendor = 5

viFdcNormal,
    viFdcStream :: Integral a => a
viFdcNormal = 1
viFdcStream = 2

viLocalSpace,
    viA16Space,
    viA24Space,
    viA32Space,
    viA64Space,
    viPxiAllocSpace,
    viPxiCfgSpace,
    viPxiBar0Space,
    viPxiBar1Space,
    viPxiBar2Space,
    viPxiBar3Space,
    viPxiBar4Space,
    viPxiBar5Space,
    viOpaqueSpace :: Integral a => a
viLocalSpace    = 0
viA16Space      = 1
viA24Space      = 2
viA32Space      = 3
viA64Space      = 4
viPxiAllocSpace = 9
viPxiCfgSpace   = 10
viPxiBar0Space  = 11
viPxiBar1Space  = 12
viPxiBar2Space  = 13
viPxiBar3Space  = 14
viPxiBar4Space  = 15
viPxiBar5Space  = 16
viOpaqueSpace   = 0xFFFF

viUnknownLa,
    viUnknownSlot,
    viUnknownLevel,
    viUnknownChassis :: Integral a => a
viUnknownLa      = -1
viUnknownSlot    = -1
viUnknownLevel   = -1
viUnknownChassis = -1

viQueue,
    viHndlr,
    viSuspendHndlr,
    viAllMech :: Integral a => a
viQueue        = 1
viHndlr        = 2
viSuspendHndlr = 4
viAllMech      = 0xFFFF

viAnyHndlr :: Integral a => a
viAnyHndlr = 0

viTrigAll,
    viTrigSw,
    viTrigTtl0,
    viTrigTtl1,
    viTrigTtl2,
    viTrigTtl3,
    viTrigTtl4,
    viTrigTtl5,
    viTrigTtl6,
    viTrigTtl7,
    viTrigEcl0,
    viTrigEcl1,
    viTrigEcl2,
    viTrigEcl3,
    viTrigEcl4,
    viTrigEcl5,
    viTrigStarSlot1,
    viTrigStarSlot2,
    viTrigStarSlot3,
    viTrigStarSlot4,
    viTrigStarSlot5,
    viTrigStarSlot6,
    viTrigStarSlot7,
    viTrigStarSlot8,
    viTrigStarSlot9,
    viTrigStarSlot10,
    viTrigStarSlot11,
    viTrigStarSlot12,
    viTrigStarInstr,
    viTrigPanelIn,
    viTrigPanelOut,
    viTrigStarVxi0,
    viTrigStarVxi1,
    viTrigStarVxi2 :: Integral a => a
viTrigAll        = -2
viTrigSw         = -1
viTrigTtl0       = 0
viTrigTtl1       = 1
viTrigTtl2       = 2
viTrigTtl3       = 3
viTrigTtl4       = 4
viTrigTtl5       = 5
viTrigTtl6       = 6
viTrigTtl7       = 7
viTrigEcl0       = 8
viTrigEcl1       = 9
viTrigEcl2       = 10
viTrigEcl3       = 11
viTrigEcl4       = 12
viTrigEcl5       = 13
viTrigStarSlot1  = 14
viTrigStarSlot2  = 15
viTrigStarSlot3  = 16
viTrigStarSlot4  = 17
viTrigStarSlot5  = 18
viTrigStarSlot6  = 19
viTrigStarSlot7  = 20
viTrigStarSlot8  = 21
viTrigStarSlot9  = 22
viTrigStarSlot10 = 23
viTrigStarSlot11 = 24
viTrigStarSlot12 = 25
viTrigStarInstr  = 26
viTrigPanelIn    = 27
viTrigPanelOut   = 28
viTrigStarVxi0   = 29
viTrigStarVxi1   = 30
viTrigStarVxi2   = 31

viTrigProtDefault,
    viTrigProtOn,
    viTrigProtOff,
    viTrigProtSync,
    viTrigProtReserve,
    viTrigProtUnreserve :: Integral a => a
viTrigProtDefault   = 0
viTrigProtOn        = 1
viTrigProtOff       = 2
viTrigProtSync      = 5
viTrigProtReserve   = 6
viTrigProtUnreserve = 7

viReadBuf,
    viWriteBuf,
    viReadBufDiscard,
    viWriteBufDiscard,
    viIoInBuf,
    viIoOutBuf,
    viIoInBufDiscard,
    viIoOutBufDiscard :: Integral a => a
viReadBuf         = 1
viWriteBuf        = 2
viReadBufDiscard  = 4
viWriteBufDiscard = 8
viIoInBuf         = 16
viIoOutBuf        = 32
viIoInBufDiscard  = 64
viIoOutBufDiscard = 128

viFlushOnAccess,
    viFlushWhenFull,
    viFlushDisable :: Integral a => a
viFlushOnAccess = 1
viFlushWhenFull = 2
viFlushDisable  = 3

viNmapped,
    viUseOpers,
    viDerefAddr,
    viDerefAddrByteSwap :: Integral a => a
viNmapped           = 1
viUseOpers          = 2
viDerefAddr         = 3
viDerefAddrByteSwap = 4

viTmoImmediate :: Integral a => a
viTmoImmediate = 0

viTmoInfinite :: Integral a => a
viTmoInfinite  = 0xFFFFFFFF

viNoLock,
    viExclusiveLock,
    viSharedLock,
    viLoadConfig :: Integral a => a
viNoLock        = 0
viExclusiveLock = 1
viSharedLock    = 2
viLoadConfig    = 4

viNoSecAddr :: Integral a => a
viNoSecAddr = 0xFFFF

viAsrlParNone,
    viAsrlParOdd,
    viAsrlParEven,
    viAsrlParMark,
    viAsrlParSpace :: Integral a => a
viAsrlParNone  = 0
viAsrlParOdd   = 1
viAsrlParEven  = 2
viAsrlParMark  = 3
viAsrlParSpace = 4

viAsrlStopOne,
    viAsrlStopOne5,
    viAsrlStopTwo :: Integral a => a
viAsrlStopOne  = 10
viAsrlStopOne5 = 15
viAsrlStopTwo  = 20

viAsrlFlowNone,
    viAsrlFlowXonXoff,
    viAsrlFlowRtsCts,
    viAsrlFlowDtrDsr :: Integral a => a
viAsrlFlowNone    = 0
viAsrlFlowXonXoff = 1
viAsrlFlowRtsCts  = 2
viAsrlFlowDtrDsr  = 4

viAsrlEndNone,
    viAsrlEndLastBit,
    viAsrlEndTermchar,
    viAsrlEndBreak :: Integral a => a
viAsrlEndNone     = 0
viAsrlEndLastBit  = 1
viAsrlEndTermchar = 2
viAsrlEndBreak    = 3

viStateAsserted,
    viStateUnasserted,
    viStateUnknown :: Integral a => a
viStateAsserted   = 1
viStateUnasserted = 0
viStateUnknown    = -1

viBigEndian,
    viLittleEndian :: Integral a => a
viBigEndian    = 0
viLittleEndian = 1

viDataPriv,
    viDataNpriv,
    viProgPriv,
    viProgNpriv,
    viBlckPriv,
    viBlckNpriv,
    viD64Priv,
    viD64Npriv,
    viD642evme,
    viD64Sst160,
    viD64Sst267,
    viD64Sst320 :: Integral a => a
viDataPriv  = 0
viDataNpriv = 1
viProgPriv  = 2
viProgNpriv = 3
viBlckPriv  = 4
viBlckNpriv = 5
viD64Priv   = 6
viD64Npriv  = 7
viD642evme  = 8
viD64Sst160 = 9
viD64Sst267 = 10
viD64Sst320 = 11

viWidth8,
    viWidth16,
    viWidth32,
    viWidth64 :: Integral a => a
viWidth8  = 1
viWidth16 = 2
viWidth32 = 4
viWidth64 = 8

viGpibRenDeassert,
    viGpibRenAssert,
    viGpibRenDeassertGtl,
    viGpibRenAssertAddress,
    viGpibRenAssertLlo,
    viGpibRenAssertAddressLlo,
    viGpibRenAddressGtl :: Integral a => a
viGpibRenDeassert         = 0
viGpibRenAssert           = 1
viGpibRenDeassertGtl      = 2
viGpibRenAssertAddress    = 3
viGpibRenAssertLlo        = 4
viGpibRenAssertAddressLlo = 5
viGpibRenAddressGtl       = 6

viGpibAtnDeassert,
    viGpibAtnAssert,
    viGpibAtnDeassertHandshake,
    viGpibAtnAssertImmediate :: Integral a => a
viGpibAtnDeassert          = 0
viGpibAtnAssert            = 1
viGpibAtnDeassertHandshake = 2
viGpibAtnAssertImmediate   = 3

viGpibHs488Disabled,
    viGpibHs488Nimpl :: Integral a => a
viGpibHs488Disabled = 0
viGpibHs488Nimpl    = -1

viGpibUnaddressed,
    viGpibTalker,
    viGpibListener :: Integral a => a
viGpibUnaddressed = 0
viGpibTalker      = 1
viGpibListener    = 2

viVxiCmd16,
    viVxiCmd16Resp16,
    viVxiResp16,
    viVxiCmd32,
    viVxiCmd32Resp16,
    viVxiCmd32Resp32,
    viVxiResp32 :: Integral a => a
viVxiCmd16       = 0x0200
viVxiCmd16Resp16 = 0x0202
viVxiResp16      = 0x0002
viVxiCmd32       = 0x0400
viVxiCmd32Resp16 = 0x0402
viVxiCmd32Resp32 = 0x0404
viVxiResp32      = 0x0004

viAssertSignal,
    viAssertUseAssigned,
    viAssertIrq1,
    viAssertIrq2,
    viAssertIrq3,
    viAssertIrq4,
    viAssertIrq5,
    viAssertIrq6,
    viAssertIrq7 :: Integral a => a
viAssertSignal      = -1
viAssertUseAssigned = 0
viAssertIrq1        = 1
viAssertIrq2        = 2
viAssertIrq3        = 3
viAssertIrq4        = 4
viAssertIrq5        = 5
viAssertIrq6        = 6
viAssertIrq7        = 7

viUtilAssertSysreset,
    viUtilAssertSysfail,
    viUtilDeassertSysfail :: Integral a => a
viUtilAssertSysreset  = 1
viUtilAssertSysfail   = 2
viUtilDeassertSysfail = 3

viVxiClassMemory,
    viVxiClassExtended,
    viVxiClassMessage,
    viVxiClassRegister,
    viVxiClassOther :: Integral a => a
viVxiClassMemory   = 0
viVxiClassExtended = 1
viVxiClassMessage  = 2
viVxiClassRegister = 3
viVxiClassOther    = 4

viPxiAddrNone,
    viPxiAddrMem,
    viPxiAddrIo,
    viPxiAddrCfg :: Integral a => a
viPxiAddrNone = 0
viPxiAddrMem  = 1
viPxiAddrIo   = 2
viPxiAddrCfg  = 3

viTrigUnknown :: Integral a => a
viTrigUnknown = -1

viPxiLbusUnknown,
    viPxiLbusNone,
    viPxiLbusStarTrigBus0,
    viPxiLbusStarTrigBus1,
    viPxiLbusStarTrigBus2,
    viPxiLbusStarTrigBus3,
    viPxiLbusStarTrigBus4,
    viPxiLbusStarTrigBus5,
    viPxiLbusStarTrigBus6,
    viPxiLbusStarTrigBus7,
    viPxiLbusStarTrigBus8,
    viPxiLbusStarTrigBus9,
    viPxiStarTrigController :: Integral a => a
viPxiLbusUnknown        = -1
viPxiLbusNone           = 0
viPxiLbusStarTrigBus0   = 1000
viPxiLbusStarTrigBus1   = 1001
viPxiLbusStarTrigBus2   = 1002
viPxiLbusStarTrigBus3   = 1003
viPxiLbusStarTrigBus4   = 1004
viPxiLbusStarTrigBus5   = 1005
viPxiLbusStarTrigBus6   = 1006
viPxiLbusStarTrigBus7   = 1007
viPxiLbusStarTrigBus8   = 1008
viPxiLbusStarTrigBus9   = 1009
viPxiStarTrigController = 1413

{- National Instruments -}
viIntfRio,
    viIntfFirewire :: Integral a => a
viIntfRio      = 8
viIntfFirewire = 9

viAttrSyncMxiAllowEn :: Integral a => a
viAttrSyncMxiAllowEn = 0x3FFF0161

{- Misc -}
viAttrFirewireDestUpperOffset,
    viAttrFirewireSrcUpperOffset,
    viAttrFirewireWinUpperOffset,
    viAttrFirewireVendorId,
    viAttrFirewireLowerChipId,
    viAttrFirewireUpperChipId :: Integral a => a
viAttrFirewireDestUpperOffset = 0x3FFF01F0
viAttrFirewireSrcUpperOffset  = 0x3FFF01F1
viAttrFirewireWinUpperOffset  = 0x3FFF01F2
viAttrFirewireVendorId        = 0x3FFF01F3
viAttrFirewireLowerChipId     = 0x3FFF01F4
viAttrFirewireUpperChipId     = 0x3FFF01F5

viFirewireDfltSpace :: Integral a => a
viFirewireDfltSpace = 5

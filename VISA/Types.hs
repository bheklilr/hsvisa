module VISA.Types
    ( ViInt8, ViUInt8
    , ViInt16, ViUInt16
    , ViInt32, ViUInt32
    , ViChar, ViByte
    , ViAddr
    , ViReal32, ViReal64
    , ViBuf, ViString
    , ViRsrc
    , ViBoolean
    , ViStatus
    , ViVersion
    , ViObject
    , ViSession
    , ViAttr, ViAttrState
    , ViConstString
    , ViBusAddress, ViBusSize
    , ViFindList
    , ViEvent, ViEventType, ViEventFilter
    , ViKeyId, ViJobId
    , ViAccessMode
    , ViHndlr
    ) where

import Foreign
import Foreign.C.Types

type ViInt8        = Int8
type ViUInt8       = CUChar
type ViInt16       = Int16
type ViUInt16      = CUShort
type ViInt32       = CInt
type ViUInt32      = CUInt

type ViChar        = CChar
type ViByte        = CUChar
type ViBuf         = Ptr ViByte
type ViString      = Ptr ViChar
type ViConstString = Ptr ViChar

type ViAddr        = Ptr ()

type ViReal32      = CFloat
type ViReal64      = CDouble

type ViRsrc        = ViString
type ViBoolean     = ViUInt16
type ViStatus      = ViInt32
type ViVersion     = ViUInt32
type ViObject      = ViUInt32
type ViSession     = ViObject

type ViAttr        = ViUInt32
type ViAttrState   = ViUInt32

type ViEvent       = ViObject
type ViEventType   = ViUInt32
type ViEventFilter = ViUInt32

type ViBusAddress  = ViUInt32
type ViBusSize     = ViUInt32

type ViFindList    = ViObject

type ViKeyId       = ViString
type ViJobId       = ViUInt32

type ViAccessMode  = ViUInt32

--type ViHndlr = Ptr (ViSession -> ViEventType -> ViEvent -> ViAddr)
type ViHndlr = Ptr ()

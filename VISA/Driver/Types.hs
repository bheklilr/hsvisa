-- | VISA type aliases.  Nothing much interesting here unless you want to know the internals.
module VISA.Driver.Types
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


-- | A VISA type alias.
type ViInt8 = Int8

-- | A VISA type alias.
type ViUInt8 = CUChar

-- | A VISA type alias.
type ViInt16 = Int16

-- | A VISA type alias.
type ViUInt16 = CUShort

-- | A VISA type alias.
type ViInt32 = CInt

-- | A VISA type alias.
type ViUInt32 = CUInt


-- | A VISA type alias.
type ViChar = CChar

-- | A VISA type alias.
type ViByte = CUChar

-- | A VISA type alias.
type ViBuf = Ptr ViByte

-- | A VISA type alias.
type ViString = Ptr ViChar

-- | A VISA type alias.
type ViConstString = Ptr ViChar

-- | A VISA type alias.
type ViAddr = Ptr ()


-- | A VISA type alias.
type ViReal32 = CFloat

-- | A VISA type alias.
type ViReal64 = CDouble


-- | A VISA type alias.
type ViRsrc = ViString

-- | A VISA type alias.
type ViBoolean = ViUInt16

-- | A VISA type alias.
type ViStatus = ViInt32

-- | A VISA type alias.
type ViVersion = ViUInt32

-- | A VISA type alias.
type ViObject = ViUInt32

-- | A VISA type alias.
type ViSession = ViObject

-- | A VISA type alias.
type ViAttr = ViUInt32

-- | A VISA type alias.
type ViAttrState = ViUInt32


-- | A VISA type alias.
type ViEvent = ViObject

-- | A VISA type alias.
type ViEventType = ViUInt32

-- | A VISA type alias.
type ViEventFilter = ViUInt32

-- | A VISA type alias.
type ViBusAddress = ViUInt32

-- | A VISA type alias.
type ViBusSize = ViUInt32

-- | A VISA type alias.
type ViFindList = ViObject

-- | A VISA type alias.
type ViKeyId = ViString


-- | A VISA type alias.
type ViJobId = ViUInt32

-- | A VISA type alias.
type ViAccessMode = ViUInt32

-- | A VISA type alias.
type ViHndlr = Ptr ()
--type ViHndlr = Ptr (ViSession -> ViEventType -> ViEvent -> ViAddr)

import strformat, tables, json, strutils, hashes


type
    BencodeKind* = enum
        btString, btInt, btList, btDict

    BencodeType* = ref object
        case kind*: BencodeKind
        of btString: s*: string
        of btInt: i*: int
        of btList: l*: seq[BencodeType]
        of btDict: d*: OrderedTable[BencodeType, BencodeType]

    Encoder* = ref object
    Decoder* = ref object

proc hash*(obj: BencodeType): Hash =
    case obj.kind
    of btString: !$(hash(obj.s))
    of btInt: !$(hash(obj.i))
    of btList: !$(hash(obj.l))
    of btDict:
        var h = 0
        for k, v in obj.d.pairs:
            h = h and !$(hash(k)) !$(hash(v))

proc `==`*(a, b: BencodeType): bool =
    if a.isNil:
        if b.isNil: return true

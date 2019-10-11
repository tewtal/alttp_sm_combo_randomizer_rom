**Communication rewrite notes**

Make space in SRAM for full outgoing / incoming item lists (to allow for replay in both directions from a given point)
Keep persistent pointers in "outside game" SRAM that tracks how many items we've sent/received and also these are indexes to the above list.
Track item recieved pointer in SM general SRAM (so that it gets saved/restored) and use that to replay received items after death. (removes need for autosave)
Log all item transactions on the server using the same id:s, so we can have the client periodically ask the server for it and compared to the local console.
If there's a mismatch between either sent or received items, we resend / request all items from/to the desync point.
Add option to "drop out" of the game and have server distribute the remaining items from that player (using seed data on the server).

Rewrite message protocol to use these new item lists and simplify the protocol to make it less "generic" since it'll only be used for item sending/receiving.

316 items in game, 4 bytes per item  (round to 350 in case we do something silly) = 1400 bytes per list
This means we'll have to expand SRAM size one extra step (beware of compatiblity issues here)



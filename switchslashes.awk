{
    match($0,/([[:space:][:cntrl:]|*\/\\]+)(.*)/,a) # find the segment of the graph
    tgt = substr($0,RSTART,RLENGTH)     # save that segment in a variable tgt
    gsub(/\//,RS,tgt)                   # change all /s to newlines in tgt
    gsub(/\\/,"/",tgt)                  # change all \s to /s in tgt
    gsub(RS,"\\",tgt)                   # change all newlines to \s in tgt
    gsub(/_/,"¯",tgt)                   # change all _ to ¯ in tgt
    print tgt substr($0,RSTART+RLENGTH) # print tgt plus rest of the line
}

module Advent_02 =
    let input = [|
        "efmyhuxcqqldtwjzvisepargvo"
        "efuyhuxckqldtwjrvrsbpargno"
        "efmyhuxckqlxtwjxvisbpargoo"
        "efmyhuxczqbdtwjzvisbpargjo"
        "efmyhugckqldtwjzvisfpargnq"
        "tfmyhuxckqljtwjzvisbpargko"
        "efmyhuxckqldtvuzvisbpavgno"
        "efmyhufcrqldtwjzvishpargno"
        "tfmyhuxbkqlduwjzvisbpargno"
        "efayhtxckqldbwjzvisbpargno"
        "efgyhuxckuldtwjzvisbpardno"
        "efmyhuxckuldtwizvisbpargqo"
        "efmyhuxcknldtjjzvihbpargno"
        "efmyhuxcnqddtwjzvisbpafgno"
        "efmyhubokqldtwjzvisbpargdo"
        "efmhhuxckqldtwdzvisbpjrgno"
        "efmyhuxckqldtwjrcisbpargny"
        "efmyhuxckqsdtwjzlisbpargng"
        "effyhuxckqlqtwjzjisbpargno"
        "nfmyhjxckqldtwjzcisbpargno"
        "efmyhvxckqldtwszvwsbpargno"
        "efmyhuxckqldtwutvisbpprgno"
        "kfmyhuxckqldtwzuvisbpargno"
        "efhyhtxckqldtwjmvisbpargno"
        "efmyhuhckqldtwjzvisbpxwgno"
        "efmyhuxcfqldtrjzvitbpargno"
        "efmyhudckqldtwjfvisbparvno"
        "ekmyhuxckqlstwjzvisbdargno"
        "efmyhuxckqlxtwjftisbpargno"
        "etsyhuxckqldtwjzvisbpargnf"
        "exmyhusckqldtwjzvisbpakgno"
        "efmyhubckqlrtljzvisbpargno"
        "efmyhuxckwldtwjovizbpargno"
        "efmyhulckqzdtwjzvisbpargpo"
        "efmyhuxckbcdlwjzvisbpargno"
        "zfmyhulckqbdtwjzvisbpargno"
        "efmyquxckfldtwazvisbpargno"
        "efxyhuxakqldtwjzvisupargno"
        "efmlhuxckkedtwjzvisbpargno"
        "efhyhuxwkqldtwjzvisbparjno"
        "efmyhuxfkqldtwjzvisvparyno"
        "efmyhuxckqfdtijzvisblargno"
        "efmyhuxckqldtfjzvisbwhrgno"
        "efmymuxcknldtwzzvisbpargno"
        "eomybuxckqldtwkzvisbpargno"
        "pfmyhuxckqldtwgzvasbpargno"
        "vfmyhuxcoqldtwjzvisbparvno"
        "eflyhuxckqldtwjzvirypargno"
        "efmyvuxckqldtwizvisbpaqgno"
        "epmyhuxckqldtwjzvesbparpno"
        "efoyhuxckoldtwjmvisbpargno"
        "efmyhuxckqydtwpzvisbpaqgno"
        "efmyhuxckqldezbzvisbpargno"
        "efmyhuxckqldtwjzvisboalxno"
        "efmyhuxckqldtwuzvipbjargno"
        "efmymuxcuqldtwjzvasbpargno"
        "jfmyhuxckqldtwjzvzsbpargdo"
        "nfmyhuxckqlntsjzvisbpargno"
        "efmxhuxckqgdtwjzvisbparjno"
        "efmyhuxckpldtpjzvpsbpargno"
        "efmyhuxcyqldtwjhvisbpargqo"
        "efmyhexgkqydtwjzvisbpargno"
        "ffmyhuxckqldtwjzvisbpafgnk"
        "efmyfuxckqldtwjpvisbpartno"
        "efmyhoxckcmdtwjzvisbpargno"
        "efmyhuxxkqldtwjzviabparyno"
        "jfmyhuxakqldtwgzvisbpargno"
        "efmjhuxckqcdtwjzvisbjargno"
        "efmyhuxccqldtwjzxisbxargno"
        "efmyhurckqldiwjzvrsbpargno"
        "efmyhuxckasdtwjzvisboargno"
        "efmyhvxckmldtwjgvisbpargno"
        "efmyhuxckoldtwjuvisbpardno"
        "efmyduxckqldtwjgvzsbpargno"
        "ejmyhuxckqldtwbzvisbpargnb"
        "efmymuxchqldtwjzvibbpargno"
        "efmyhjxckqldtwjgvinbpargno"
        "efmyhuxhyqldtwbzvisbpargno"
        "efmyhuxckqldtwjzvisbpzignq"
        "efmyuueckqldxwjzvisbpargno"
        "qfmyhyxckqldtwizvisbpargno"
        "efmyhupckqldtwjzvpgbpargno"
        "efmycuxckqldtwjzvfdbpargno"
        "efmyhugcrqldtwjfvisbpargno"
        "efmyhexckqldtwjzvischargno"
        "efmyhuxckqldtljzvasbpamgno"
        "efmyzdxckqldtwjovisbpargno"
        "efmyhuxccqldtwjzvdsbpaigno"
        "ufmyhuxekqldtwjzvisbpargne"
        "efmyhuxckqldfwozvisgpargno"
        "afmyhuackqldtwjzvisbdargno"
        "efmyauxckqldtwjzvisiparmno"
        "efmysuxckqldtwjzvisbeaggno"
        "efmyhuxckqldtwjzvisbgzigno"
        "efryhuxlkqldtwozvisbpargno"
        "lfmyhuxckqldtwjzvhsbparuno"
        "efmyhzxckqldswjzvisqpargno"
        "efmyhuxrkqldtwjzvisgpargco"
        "efmyhudckqldtwjzyisbkargno"
        "efmyhuacqqldtwjzviabpargno"
        "jfmyhuxckqldtwvzvicbpargno"
        "efmkhuxckqlftejzvisbpargno"
        "nfmyhuxckqldnwjzvisbxargno"
        "efmyhuxckqldtwjvvisjpyrgno"
        "efmyhuxcmxldtwjzvisbpargto"
        "efmyhuxckqldtwqbvpsbpargno"
        "efmyhuxckzldjwjzvisbplrgno"
        "efmywgxckqldtwxzvisbpargno"
        "efmsguxckqldhwjzvisbpargno"
        "nfmyhuxlkqldtwjzvisbgargno"
        "etmyhuxckqldtwjzvqsbptrgno"
        "efmyxuxckqldtfjzvisbyargno"
        "cfmihuxckqldtwjzvisbpargnf"
        "jfzyhuxckqldtwjzviscpargno"
        "efmyhuxckqldtmjzvisbpbzgno"
        "bfmyhuzckqldcwjzvisbpargno"
        "efmyhuxckqldtmjzvmslpargno"
        "efqyvuxckqldtwazvisbpargno"
        "efmecrxckqldtwjzvisbpargno"
        "efmyhuuckqldtwjzvisrpargnt"
        "efmphuxckqldtwjzvisbparmho"
        "ifmyhuxckqldtwjzvismpsrgno"
        "efmyhuookqldywjzvisbpargno"
        "efmyhfxckyldtwjnvisbpargno"
        "efmyhxhckqldtwjzvisqpargno"
        "efryhuxcfqldtwjzvisbparkno"
        "efmyhutckqldpwjzvixbpargno"
        "efmyoukckqldtwjzvisbpargko"
        "efmyhuxckqldtwjzviseparynv"
        "efmyhuxcksldvwjzvisbnargno"
        "efmyhuxckqrdtwlzmisbpargno"
        "efmyhuxcwqldtwjzviqapargno"
        "eymyhuxckqrdtwkzvisbpargno"
        "efmyhuxckqldtwjzpisopargnj"
        "efmyhuxikqldtwjzvirupargno"
        "efmyhuxcuzldtnjzvisbpargno"
        "efmyhxxikqldtwjzvisbpalgno"
        "efmyhuxceqldtwjzvdsbparguo"
        "efmyhuxwkqldtwjmvisbparxno"
        "efmyhuxpkqldtwjzvisfpargfo"
        "efmyfuxckaldtwjzvirbpargno"
        "efmyhuxckqrdtwjzvismprrgno"
        "efmyhuxckqldzwjzvisbpnrgfo"
        "efmyhfuckqldtwjyvisipargno"
        "efmyhuxcpqlqfwjzvisbpargno"
        "efmyyuxckqldtwjzvrsepargno"
        "efmphuxckqlptqjzvisbpargno"
        "efmyhuxnfqldtwjzvisbpmrgno"
        "efmyhuxckqldtwjzkisnpnrgno"
        "mfmyhuxckqldtwjzvisbzarcno"
        "efmyhuxckqldtwlzviszpargwo"
        "efmytuxckqndtwjqvisbpargno"
        "efmyzuxckqldtwjzvisbaargjo"
        "efmihuxckqlutwjzvimbpargno"
        "efmyhuxckqldgwjzvixbparono"
        "tfmyduxckqldtyjzvisbpargno"
        "ejmyhuockqldtwjzvidbpargno"
        "efmyheyckqkdtwjzvisbpargno"
        "efmyhuxckqldtwjzoisbpargfj"
        "efqyhuxcxqldtwxzvisbpargno"
        "jfmyhaxckqldtwjzvisbvargno"
        "hfmyhqxckqldtwjzvisbparvno"
        "efmyhukckqlrtwjzvqsbpargno"
        "efmyhuxckqldvwmzvisbparrno"
        "efoyhuxckqldtwjzvilwpargno"
        "ejmyhuxckqldtwjzxisbprrgno"
        "efmyhuxckqldtsjzvisupdrgno"
        "efzyhjxckqldtwjzvisbpasgno"
        "ebmyhulckqldtwjzvisbpargnr"
        "efmyhuxcjqlntwjzqisbpargno"
        "efmlocxckqldtwjzvisbpargno"
        "efmyhuxckqldtwjzvizkpargnm"
        "ebmyhuxckqldtwjzvlfbpargno"
        "efmyhuxckqldtwjyvisbpjrgnq"
        "afmyhuxckqldtwjzvpsbpargnv"
        "efmyxuxckqwdzwjzvisbpargno"
        "efmyhuxskqlqthjzvisbpargno"
        "efmyhuxckqldtwdzvisbearglo"
        "mfmyhuxckqldtzjzvisbparggo"
        "efmyhuqckqodtwjzvisbpadgno"
        "efmyhuxctqldywjzvisspargno"
        "efmyhuxckqqdtwjnvisbporgno"
        "efmyhixckqldowjzvisbpaagno"
        "efmyhuxckqldtsszvisbpargns"
        "edmyhuxckqpdtwjzrisbpargno"
        "efsyhuxckqldtijzvisbparano"
        "efmyhuxckqxdzwjzviqbpargno"
        "efmyhuxckqldtwjzviqqpsrgno"
        "efmyhuockqlatwjzvisbpargho"
        "efmyhuxckqldtwjzvishkavgno"
        "vfmyhuxckqldtwjzvksbaargno"
        "efmahuxckqudtwbzvisbpargno"
        "ewmyhixckqudtwjzvisbpargno"
        "efmywuxczqldtwjzvisbpargao"
        "efmyhuqjkqldtwyzvisbpargno"
        "efmyhuxekqldtwjzmksbpargno"
        "efmyhuxcoqtdtwjzvinbpargno"
        "ebmyhuxkkqldtwjzvisbdargno"
        "ecmyhnxckqldtwnzvisbpargno"
        "efmyhuxbkqldtwjzvksbpaigno"
        "efayhuxckqidtwjzvisbpavgno"
        "efmrhuxckqldswjzvisbpaugno"
        "efmyhuuckqldtwjyvisipargno"
        "xfmyhuxckqldawjzvosbpargno"
        "efmyhuxckklhtwjzvisbpargnq"
        "efmyhmxcaqldzwjzvisbpargno"
        "efiyhuxcksldtwjzvisbpamgno"
        "zfmyhuzckqldtwjzvisbparhno"
        "efmyhuxckqlvtwjdvisbparsno"
        "efmyhmxckaldtwjzmisbpargno"
        "efmysuxcqoldtwjzvisbpargno"
        "efmyhuxckqldtwjzvisbsargrb"
        "effyhuxckqldtwjzvisbpwfgno"
        "efmyhuxclqmdtwjzxisbpargno"
        "edmohuxckqldtwjziisbpargno"
        "efmyhuxckpldtwjzviubpaegno"
        "efmyhuxcpqldtwjzjimbpargno"
        "ehmyhuxckqldtwjzsisbpargnq"
        "efmyhcxcdqldtwjzvisbqargno"
        "efmjhuxckqldmwjzviybpargno"
        "efeyhzxckqlxtwjzvisbpargno"
        "efmyhuxczqadtwazvisbpargno"
        "efmahuxckqldtwjzvisbpafgnl"
        "efmyouxckqldtwjzvizbpacgno"
        "emmrhuxckqldtwjzvisqpargno"
        "exmyhuxckqlftwjnvisbpargno"
        "efuyhuxckqldrwjzvisbpargnw"
        "efmywuxfkqldtwjztisbpargno"
        "efmyhuxdkqldtwjzvisbpqrzno"
        "eemyhuxckqldrwjzvisbpajgno"
        "efmyiuxckqldtbjzvrsbpargno"
        "eqmyhuxckqldlwjzfisbpargno"
        "efmyhuxckqlitwuzvisbpvrgno"
        "ecoyhuxckqldtwjzvishpargno"
        "efmyhuxckcldtwjzlisbparlno"
        "efmyhsxcknldtwjfvisbpargno"
        "efmyhuxckqldtwjrvosbpargbo"
        "enmehuxckzldtwjzvisbpargno"
        "hfmyhuxckqqdtwjzvisbpawgno"
        "efmyhufckcjdtwjzvisbpargno"
        "efmxhuxckqldthjzvisfpargno"
        "efmyaukckqldtwjsvisbpargno"
        "efmyhukckqldtwpzvisbpmrgno"
        "dfmyhuxckqldtwjzvisbvarmno"
        "afmbhuxckqldtwjzvssbpargno"
        "efmyhuxchqldtwezvisbpargzo"
        "efmphuxckqlxjwjzvisbpargno"
        "efhyxuxckqldtwjzvisbpargko"
        "sfmyhexckqldtwjzvisbqargno"
        "efmghuxckqldtwjzvitbparnno"
    |]

    // Part 1
    let summer = fun (two : int, three : int) (st : string) -> 
        let counts = st.ToCharArray()
                    |> Array.groupBy id
                    |> Array.map (fun (k,v) -> v.Length)
                    |> Set.ofArray

        let convert = fun n -> if counts.Contains n then 1 else 0

        let ntwo   = convert 2
        let nthree = convert 3

        (two + ntwo, three + nthree)

    let partial = input |> Array.fold summer (0,0)
    let result1 = fst partial * snd partial

    // Part 2
    let findBoxes = fun (boxes : string[]) ->
        let transformedNames = boxes
                                |> Array.mapi (fun i s -> (i, s.ToCharArray() |> List.ofArray))
                                |> List.ofArray

        let rec processNames = fun (names : (int * char list) list) ->

            let partitions = names |> List.partition (fun (_, s) -> s.Length > 0)

            let minTwo = (fun l -> match l with | l1 :: l2 :: ls -> l1 :: l2 :: ls | _ -> [])

            let out = snd partitions |> minTwo |> List.map fst 
            let remaining = fst partitions |> minTwo

            if (remaining.Length >= 2) then
                let altout = remaining
                            |> List.choose (fun n -> match n with
                                                        | (i, c :: cs) -> Some (i, c, cs)
                                                        | _ -> None)
                            |> List.groupBy (fun (_, c, _) -> c)
                            |> Seq.ofList
                            |> Seq.map snd
                            |> Seq.filter (fun m -> m.Length >= 2)
                            |> Seq.collect (fun m -> m |> List.map (fun (i, _, cs) -> (i, cs))) // ? processSubList
                            |> List.ofSeq
                            |> processNames
                            |> minTwo

                List.append out altout
            else out

        processNames transformedNames

    let result2 = findBoxes input
name_codes_file = open("SIRNA_DHARMACON_DEPOOLED_HASHED_INFECTX_PRIVATE_WITH_SEQUENCE.tsv", "r")
name_codes_dictionary = {}
for line in name_codes_file:
    siRNA = line.split()[1]
    code = line.split()[2]
    name_codes_dictionary[code] = siRNA
for novartis_screens_file_name in {"BoP_BMPsignaling_A549_high_BMP2_tr.txt",
                                   "BoP_BMPsignaling_A549_low_BMP2_tr.txt",
                                   "BoP_BMPsignaling_HEK293_high_BMP2_tr.txt",
                                   "BoP_BMPsignaling_HEK293_low_BMP2_tr.txt",
                                   "BoP_BMPsignaling_HPASMC_high_BMP2_tr.txt",
                                   "BoP_BMPsignaling_HPASMC_low_BMP2_tr.txt",
                                   "BoP_NFkBsignaling_HEK293_high_IL1b_tr.txt",
                                   "BoP_NFkBsignaling_HEK293_low_IL1b_tr.txt",
                                   "BoP_NFkBsignaling_HEK293_TNFalpha_tr.txt",
                                   "BoP_TGFbsignaling_A549_high_TGFb1_tr.txt",
                                   "BoP_TGFbsignaling_A549_low_TGFb1_tr.txt",
                                   "BoP_TGFbsignaling_HEK293_high_TGFb1_tr.txt"}:
    novartis_screens_file = open("translated/%s" % novartis_screens_file_name, "r")
    first_line = novartis_screens_file.readline()
    output_file = open("translated/dharmacon_added/%s" % novartis_screens_file_name, "w")
    output_file.write(first_line)
    print(novartis_screens_file_name)
    for line in novartis_screens_file:
        line_split = line.split(" ")
        if not line_split[0].startswith("SI"):
            if line_split[1] in name_codes_dictionary:
                    line_split[2] = name_codes_dictionary[line_split[1]]
            new_line = " ".join(line_split)
            name_codes_file.close()
        else:
            new_line = line
        output_file.write(new_line)
    novartis_screens_file.close()
    output_file.close()

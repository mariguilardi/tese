def seq_filter_list(list, filter):
    """
    Filter sequences based on existence of tags
    in Genbank full records
    list: list containing sequences to filter
    filter: name of tag as string 
    """
    
    from Bio import SeqIO
    records = []

    for record in list:
        for feature in record.features:
            tag = feature.qualifiers.get(filter)
            if tag:
                records.append(record)
    
    return(records)
# resolver ambiguidades em posicoes nucleotidicas de sequencias obtidas com metodo de Sanger
# install.packages("sangerseqR")
# install.packages("stringr")

# carregando bibliotecas
library(sangerseqR)
library(stringr)

# diretorio com sequencias em formato ab1
dir <- "sequencias/"
# lista com nomes dos arquivos das sequencias
filenames <- list.files(dir) 

# criar diretorio para sequencias processadas
subDir <- "sequencias_processadas"
dir.create(file.path(dir, subDir), showWarnings = FALSE)

# basecalls para cada sequencia do diretorio dir e salva no diretorio sequencias_processadas
for (file in filenames){
  seq <- read.abif(paste0(dir, file)) 
  seq_sanger <- sangerseq(seq)
  seq_base <- makeBaseCalls(seq_sanger, ratio = 0.5) # ratio pode-se ser modificado até valor 1
  seq_primary <- primarySeq(seq_base)
  str <- as.character(seq_primary)
  name <- str_extract(file, "[^.]+")
  content <- paste0(">", name)
  content <- append(content, str)
  write(content, paste0("sequencias_processadas/",name, ".fas"))
}


# instalar pacotes
#install.packages("tidyverse")
#install.packages("ggbreak")

# importar pacotes
library(tidyverse)
library(ggbreak)

# turn off scientific notation
options(scipen = 999)

# associar dados de reads por pool a variável
data <-  read.csv("numero_reads_pools.csv", sep=";")

# checando nome das colunas e dados
colnames(data)
glimpse(data)


# convertendo tabela para formato longo dos reads total, virais e mapeados para vírus da raiva
rabies_long <- data |> select(sample, n_reads_rabies, n_reads_mapped, 
                              n_reads_filter, n_reads_total) |>
  pivot_longer(cols = n_reads_rabies:n_reads_total, names_prefix = "n_reads_", 
               names_to = "Reads")

# checando nome das colunas e dados
colnames(rabies_long)

# conversão dos nomes dos pools em fator
rabies_long$sample <- factor(rabies_long$sample, 
                                    levels = c("CNS", "GIT", "Kidney", "Fetus"))


# conversão dos tipos de reads em fator
rabies_long$Reads <- factor(rabies_long$Reads, 
                                   levels = c("total", "filter", "mapped", "rabies"))


# gráfico de reads totais, virais e mapeados no vírus da raiva
graph <- rabies_long |> filter(Reads == "rabies" |
                                        Reads == "mapped" |
                                        Reads == "total")

ggplot(graph, aes(x=sample, y = value, fill = Reads)) +
  geom_bar(position="dodge", stat="identity") +
  scale_y_break(c(15, 500, 3000, 25000, 500000, 100000000), scales = 1.0) +
  xlab("Sample") +
  ylab("Number of Reads") +
  scale_fill_discrete(name = "Type of Reads", 
                      labels = c("Total", "Mapped", "Rabies")) +
  theme_classic() +
  theme(panel.border = element_rect(colour = "black", fill=NA, linewidth=0.5))

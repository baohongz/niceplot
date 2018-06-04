library(pheatmap)

# Read in data files
test = as.matrix(read.table(file="test1.txt",header=TRUE,sep="\t",check.names=FALSE))
annotation_row = as.data.frame(read.table(file="annotation_row.txt",header=TRUE,sep="\t",check.names=FALSE))
annotation_col = as.data.frame(read.table(file="jak1_jak3_annotation_col.txt",header=TRUE,sep="\t",check.names=FALSE))

# define orders of annotation
annotation_col$Dose <- factor( annotation_col$Dose, levels = c("jak1", "jak3"))
annotation_col$Visit_Type <- factor( annotation_col$Visit_Type, levels = c("H2","H4", "H8", "H12", "H24"))
#annotation_col_order = annotation_col[ order(xtfrm(annotation_col$Visit_Type), xtfrm(annotation_col$Dose)),]
annotation_col_order = annotation_col[ order(xtfrm(annotation_col$Dose), xtfrm(annotation_col$Visit_Type)),c("Dose","Visit_Type")]
test_order = test[,rownames(annotation_col_order)]


paletteLength <- 50
myColor <- colorRampPalette(c("navy", "white", "firebrick3"))(paletteLength)
# length(breaks) == length(paletteLength) + 1
# use floor and ceiling to deal with even/odd length pallettelengths
myBreaks <- c(seq(min(test), 0, length.out=ceiling(paletteLength/2) + 1), seq(max(test)/paletteLength, max(test), length.out=floor(paletteLength/2)))

# Draw heatmaps
# pheatmap(test_order, kmeans_k = 2, scale = "row", clustering_distance_rows = "correlation")
pheatmap(test_order, color = colorRampPalette(c("navy", "white", "firebrick3"))(50))

# Show text within cells
pheatmap(test_order, cluster_row = FALSE, legend_breaks = -1:4, legend_labels = c("0", "1e-4", "1e-3", "1e-2", "1e-1", "1"))

# Fix cell sizes and save to file with correct size
pheatmap(test_order, cellwidth = 15, cellheight = 12, main = "Example heatmap")

# Display row and color annotations # Gaps in heatmaps

pheatmap(test_order, color = myColor, breaks = myBreaks, annotation_col = annotation_col_order, annotation_row = annotation_row, annotation_legend = TRUE , cluster_col = FALSE, legend = TRUE, cutree_col = 2, cutree_row = 3, fontsize=8, fontsize_col=8, fontsize_row=8, width = 8, height = 6, filename = "heatmap1.pdf")

pheatmap(test_order, color = myColor, breaks = myBreaks, annotation_col = annotation_col_order, annotation_row = annotation_row, annotation_legend = TRUE , cluster_col = FALSE, legend = TRUE, cutree_col = 2, cutree_row = 3, fontsize=8, fontsize_col=8, fontsize_row=8, width = 8, height = 6, filename = "heatmap1.png")

#pheatmap(test_order, annotation_col = annotation_col, annotation_row = annotation_row, annotation_legend = TRUE , cluster_row = TRUE, legend = TRUE, cutree_col = 2, cutree_row = 3, display_numbers = matrix(ifelse(test_order > 5, sprintf("%.2f",test_order), ""), nrow(test_order)), width = 8, height = 8, filename = "heatmap.png")

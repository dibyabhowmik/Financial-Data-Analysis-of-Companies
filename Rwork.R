library(readr)
library(dplyr)
library(stringr)
library(janitor)
library(lubridate)

df <- read_csv("C:/data Analysis project/Financial Statements.csv")

#Clean column names
df <- df %>% clean_names()

cat("Cleaned Column Names:\n")
print(names(df))

#Set 'company' column as ticker column
ticker_col <- "company"

# Preview unique values
cat("Unique company names:\n")
print(unique(df[[ticker_col]]))

#Filter for selected companies
selected_companies <- c("Apple Inc.", "Microsoft Corp", "Alphabet Inc.")  # Update if needed

df_filtered <- df %>%
  filter(!!sym(ticker_col) %in% selected_companies)

#Convert 'year' to date
if ("year" %in% names(df_filtered)) {
  df_filtered <- df_filtered %>%
    mutate(report_date = ymd(paste0(year, "-01-01")))
} else {
  cat(" No 'year' column found — skipping date conversion.\n")
}

#Convert financial value columns to numeric
non_numeric_cols <- c("report_date", "year", ticker_col, "category")
df_filtered <- df_filtered %>%
  mutate(across(.cols = !all_of(non_numeric_cols), ~ as.numeric(.)))

#Remove duplicate rows and empty columns
df_filtered <- df_filtered %>%
  distinct() %>%
  select(where(~ !all(is.na(.))))

# Export cleaned data to CSV
output_path <- "Cleaned_Financial_Data.csv"
write_csv(df_filtered, output_path)
cat(paste0("\n Cleaned data exported to: ", output_path, "\n"))

getwd()
output_path <- "C:/data Analysis project/Cleaned_Financial_Data.csv"
write_csv(df_filtered, output_path)


df <- read_csv("C:/data Analysis project/Financial Statements.csv")  # Use correct path

#Clean column names (e.g., "Company " → "company")
df <- df %>% clean_names()

#Print cleaned column names
cat(" Cleaned Column Names:\n")
print(names(df))

#View available company names (print first 10 unique)
cat(" Unique company names:\n")
print(unique(df$company)[1:10])  # Modify this if your column is different

# Step 5: Use correct company names from your dataset
selected_companies <- c("AAPL", "MSFT", "GOOG")  # Update as per actual values

#Filter dataset for selected companies
df_filtered <- df %>%
  filter(company %in% selected_companies)

# Debug: Check if data was filtered
cat(" Number of matching rows:\n")
print(nrow(df_filtered))

#Create date column if 'year' is present
if ("year" %in% names(df_filtered)) {
  df_filtered <- df_filtered %>%
    mutate(report_date = ymd(paste0(year, "-01-01")))
} else {
  cat(" No 'year' column found — skipping date conversion.\n")
}

#Convert all financial columns to numeric
non_numeric_cols <- c("company", "category", "year", "report_date")
df_filtered <- df_filtered %>%
  mutate(across(.cols = !all_of(non_numeric_cols), ~ as.numeric(.)))

#Remove duplicate rows and empty columns
df_filtered <- df_filtered %>%
  distinct() %>%
  select(where(~ !all(is.na(.))))

#Preview cleaned data
cat("Sample of cleaned data:\n")
print(head(df_filtered))


output_path <- "C:/data Analysis project/Cleaned_Financial_Data.csv"
write_csv(df_filtered, output_path)

cat(paste0("\n Cleaned data exported to: ", output_path, "\n"))





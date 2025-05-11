 # DataInjection


""" 
        Metadata
        This comprehensive set of fields will guide your analysis, helping you unravel the intricacies of client behavior and preferences.

        client_id: Every client's unique ID.
        variation: Indicates if a client was part of the experiment.
        visitor_id: A unique ID for each client-device combination.
        visit_id: A unique ID for each web visit/session.
        process_step: Marks each step in the digital process.
        date_time: Timestamp of each web activity.
        clnt_tenure_yr: Represents how long the client has been with Vanguard, measured in years.
        clnt_tenure_mnth: Further breaks down the client's tenure with Vanguard in months.
        clnt_age: Indicates the age of the client.
        gendr: Specifies the client's gender.
        num_accts: Denotes the number of accounts the client holds with Vanguard.
        bal: Gives the total balance spread across all accounts for a particular client.
        calls_6_mnth: Records the number of times the client reached out over a call in the past six months.
        logons_6_mnth: Reflects the frequency with which the client logged onto Vanguard's platform over the last six months.
"""

#import libraries
import pandas as pd

# URL for dataset
url1='https://raw.githubusercontent.com/data-bootcamp-v4/lessons/refs/heads/main/5_6_eda_inf_stats_tableau/project/files_for_project/df_final_demo.txt'
url2='https://raw.githubusercontent.com/data-bootcamp-v4/lessons/refs/heads/main/5_6_eda_inf_stats_tableau/project/files_for_project/df_final_experiment_clients.txt' ## not important
url3='https://raw.githubusercontent.com/data-bootcamp-v4/lessons/refs/heads/main/5_6_eda_inf_stats_tableau/project/files_for_project/df_final_web_data_pt_1.txt'
url4='https://raw.githubusercontent.com/data-bootcamp-v4/lessons/refs/heads/main/5_6_eda_inf_stats_tableau/project/files_for_project/df_final_web_data_pt_2.txt'


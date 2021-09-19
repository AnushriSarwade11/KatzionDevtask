**Requirements:**

Custom Objects - Transaction, Transaction Items

Make Rest API requests when Transaction Items created

**Request #1**

Total number of Transaction Items for that Transaction = Transaction count

Send Transaction Items information in JSON format

**Request #2**

If Request #1 returns Success

Send Transaction information in JSON format



**Solution**
1. Collect all Transaction Ids in a Single Apex Transactions using Apex Triggers
2. Query DB for Transaction along with Transaction Items in an inner query 
3. Compare Transaction Items related list size with Transaction Record’s field (Transaction_count)
4. If they are equal then generate both json payloads and go to step 6
5. Else continue with next transaction
6. If both payloads are not null make Transaction Item API call and go to step 8
7. Else continue with next transaction
8. Check response of Transaction Item API call, if success then call Transaction API call

**Note: Please read presentation(Katzion DevTask) attached in the same repository before reviewing solution**

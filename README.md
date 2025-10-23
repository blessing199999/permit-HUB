 permit-HUB

A Clarity smart contract for whitelist-based access control on the Stacks blockchain.

 Features

- **Admin-only whitelist management:** Only the admin can add or remove users.
- **Whitelist status checks:** Easily verify if a user is whitelisted.
- **Restricted access function:** Only whitelisted users can call certain functions.
- **Admin transfer:** Admin privileges can be transferred to another address.
- **Utility functions:** Check current admin and whitelist status.

 Contract Overview

This contract demonstrates a simple access control pattern using a whitelist and an admin principal. The admin (deployer by default) can manage the whitelist and transfer admin rights.

 Functions

 Read-Only

- `is-admin (who principal)`  
  Returns `true` if `who` is the current admin.

- `is-whitelisted (who principal)`  
  Returns `true` if `who` is on the whitelist.

- `get-admin`  
  Returns the current admin principal.

 Public (Admin Only)

- `add-to-whitelist (user principal)`  
  Adds a user to the whitelist. Returns `"User added to whitelist"` or error `u401` if unauthorized.

- `remove-from-whitelist (user principal)`  
  Removes a user from the whitelist. Returns `"User removed from whitelist"` or error `u401` if unauthorized.

- `set-admin (new-admin principal)`  
  Transfers admin privileges to `new-admin`. Returns `"Admin changed successfully"` or error `u401` if unauthorized.

 Public (Whitelisted Only)

- `restricted-action`  
  Callable only by whitelisted users. Returns `"Access granted: you are on the whitelist"` or error `u403` if forbidden.

 Error Codes

- `u401` — Unauthorized (not admin)
- `u403` — Forbidden (not whitelisted)

 Usage

1. **Deploy the contract.**  
   The deployer becomes the initial admin.

2. **Admin actions:**  
   - Add or remove users from the whitelist.
   - Transfer admin rights if needed.

3. **Users:**  
   - Call `restricted-action` if whitelisted.

Compatibility

- **Clarity:** Stacks 2.5+
- **Clarinet:** v1.0+


**Author:** GPT-5  
**Purpose:** Demonstrate access control in Clarity

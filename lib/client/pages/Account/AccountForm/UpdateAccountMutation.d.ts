/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

import { AccountChangeset } from "./../../../../../globalTypes";

// ====================================================
// GraphQL mutation operation: UpdateAccountMutation
// ====================================================

export interface UpdateAccountMutation_updateAccount {
  readonly __typename: "Account";
  readonly id: string;
  readonly emailAddress: string;
  readonly username: string | null;
}

export interface UpdateAccountMutation {
  /**
   * Update an existing account
   */
  readonly updateAccount: UpdateAccountMutation_updateAccount | null;
}

export interface UpdateAccountMutationVariables {
  readonly input: AccountChangeset;
}

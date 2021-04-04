/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

import { NewAccount } from "./../../../../../globalTypes";

// ====================================================
// GraphQL mutation operation: CreateAccountMutation
// ====================================================

export interface CreateAccountMutation_createAccount {
  readonly __typename: "Account";
  readonly id: string;
  readonly emailAddress: string;
}

export interface CreateAccountMutation {
  /**
   * Create a new account
   */
  readonly createAccount: CreateAccountMutation_createAccount | null;
}

export interface CreateAccountMutationVariables {
  readonly input: NewAccount;
}

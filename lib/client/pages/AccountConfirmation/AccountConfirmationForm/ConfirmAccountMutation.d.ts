/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

import { AccountConfirmation } from "./../../../../../globalTypes";

// ====================================================
// GraphQL mutation operation: ConfirmAccountMutation
// ====================================================

export interface ConfirmAccountMutation_confirmAccount {
  readonly __typename: "Account";
  readonly id: string;
}

export interface ConfirmAccountMutation {
  /**
   * Confirm an existing account
   */
  readonly confirmAccount: ConfirmAccountMutation_confirmAccount | null;
}

export interface ConfirmAccountMutationVariables {
  readonly input: AccountConfirmation;
}

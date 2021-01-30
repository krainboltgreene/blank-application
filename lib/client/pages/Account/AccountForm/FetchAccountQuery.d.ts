/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

import { Identity } from "./../../../../../globalTypes";

// ====================================================
// GraphQL query operation: FetchAccountQuery
// ====================================================

export interface FetchAccountQuery_account {
  readonly __typename: "Account";
  readonly id: string;
  readonly username: string | null;
  readonly emailAddress: string;
}

export interface FetchAccountQuery {
  /**
   * Get an account by id
   */
  readonly account: FetchAccountQuery_account | null;
}

export interface FetchAccountQueryVariables {
  readonly input: Identity;
}

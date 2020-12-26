/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

import { NewSession } from "./../../../../../globalTypes";

// ====================================================
// GraphQL mutation operation: CreateSessionMutation
// ====================================================

export interface CreateSessionMutation_createSession {
  readonly __typename: "Session";
  readonly id: string | null;
}

export interface CreateSessionMutation {
  /**
   * Create a new session
   */
  readonly createSession: CreateSessionMutation_createSession | null;
}

export interface CreateSessionMutationVariables {
  readonly input: NewSession;
}

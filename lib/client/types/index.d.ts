import { GraphQLResolveInfo, GraphQLScalarType, GraphQLScalarTypeConfig } from 'graphql';
export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type RequireFields<T, K extends keyof T> = { [X in Exclude<keyof T, K>]?: T[X] } & { [P in K]-?: NonNullable<T[P]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  /**
   * The `Naive DateTime` scalar type represents a naive date and time without
   * timezone. The DateTime appears in a JSON response as an ISO8601 formatted
   * string.
   */
  NaiveDateTime: any;
};

export type Account = {
  __typename?: 'Account';
  emailAddress: Scalars['String'];
  id: Scalars['ID'];
  insertedAt: Scalars['NaiveDateTime'];
  organizationMemberships?: Maybe<Array<OrganizationMembership>>;
  organizations?: Maybe<Array<Maybe<Organization>>>;
  profile: Profile;
  settings: Settings;
  updatedAt: Scalars['NaiveDateTime'];
  username?: Maybe<Scalars['String']>;
};

export type AccountChangeset = {
  emailAddress?: Maybe<Scalars['String']>;
  id: Scalars['ID'];
  password?: Maybe<Scalars['String']>;
  username?: Maybe<Scalars['String']>;
};

export type AccountConfirmation = {
  confirmationSecret: Scalars['String'];
  password: Scalars['String'];
};

export type Identity = {
  id: Scalars['ID'];
};

export type ListParameters = {
  limit?: Maybe<Scalars['Int']>;
};

export type NewAccount = {
  emailAddress: Scalars['String'];
  password?: Maybe<Scalars['String']>;
  username?: Maybe<Scalars['String']>;
};

export type NewOrganization = {
  name?: Maybe<Scalars['String']>;
};

export type NewPermission = {
  name?: Maybe<Scalars['String']>;
};

export type NewSession = {
  emailAddress: Scalars['String'];
  password: Scalars['String'];
};

export type Organization = {
  __typename?: 'Organization';
  accounts?: Maybe<Array<Account>>;
  id: Scalars['ID'];
  insertedAt: Scalars['NaiveDateTime'];
  name: Scalars['String'];
  organizationPermissions?: Maybe<Array<OrganizationPermission>>;
  permissions?: Maybe<Array<Permission>>;
  slug: Scalars['String'];
  updatedAt: Scalars['NaiveDateTime'];
};

export type OrganizationChangeset = {
  id: Scalars['ID'];
  name?: Maybe<Scalars['String']>;
};

export type OrganizationMembership = {
  __typename?: 'OrganizationMembership';
  account: Account;
  insertedAt: Scalars['NaiveDateTime'];
  organization: Organization;
  organizationPermissions?: Maybe<Array<OrganizationPermission>>;
  updatedAt: Scalars['NaiveDateTime'];
};

export type OrganizationPermission = {
  __typename?: 'OrganizationPermission';
  insertedAt: Scalars['NaiveDateTime'];
  organization: Organization;
  permission: Permission;
  updatedAt: Scalars['NaiveDateTime'];
};

export type Permission = {
  __typename?: 'Permission';
  id: Scalars['ID'];
  insertedAt: Scalars['NaiveDateTime'];
  name: Scalars['String'];
  organizationPermissions?: Maybe<Array<OrganizationPermission>>;
  slug: Scalars['String'];
  updatedAt: Scalars['NaiveDateTime'];
};

export type PermissionChangeset = {
  id: Scalars['ID'];
  name?: Maybe<Scalars['String']>;
};

export type Profile = {
  __typename?: 'Profile';
  id: Scalars['ID'];
  publicName?: Maybe<Scalars['String']>;
};

export type ProfileChangeset = {
  id: Scalars['ID'];
  publicName?: Maybe<Scalars['String']>;
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  /** Confirm an existing account */
  confirmAccount?: Maybe<Account>;
  /** Create a new account */
  createAccount?: Maybe<Account>;
  /** Create a new organization */
  createOrganization?: Maybe<Organization>;
  /** Create a new permission */
  createPermission?: Maybe<Permission>;
  /** Create a new session */
  createSession?: Maybe<Session>;
  /** Permanently delete an existing account */
  destroyAccount?: Maybe<Account>;
  /** Permanently delete an existing organization */
  destroyOrganization?: Maybe<Organization>;
  /** Permanently delete an existing permission */
  destroyPermission?: Maybe<Permission>;
  /** Permanently delete an existing session */
  destroySession?: Maybe<Session>;
  /** Update an existing account */
  updateAccount?: Maybe<Account>;
  /** Update an existing organization */
  updateOrganization?: Maybe<Organization>;
  /** Update an existing permission */
  updatePermission?: Maybe<Permission>;
  /** Update an existing profile */
  updateProfile?: Maybe<Profile>;
  /** Update an existing settings */
  updateSettings?: Maybe<Settings>;
};


export type RootMutationTypeConfirmAccountArgs = {
  input: AccountConfirmation;
};


export type RootMutationTypeCreateAccountArgs = {
  input: NewAccount;
};


export type RootMutationTypeCreateOrganizationArgs = {
  input: NewOrganization;
};


export type RootMutationTypeCreatePermissionArgs = {
  input: NewPermission;
};


export type RootMutationTypeCreateSessionArgs = {
  input: NewSession;
};


export type RootMutationTypeDestroyAccountArgs = {
  input: Identity;
};


export type RootMutationTypeDestroyOrganizationArgs = {
  input: Identity;
};


export type RootMutationTypeDestroyPermissionArgs = {
  input: Identity;
};


export type RootMutationTypeUpdateAccountArgs = {
  input: AccountChangeset;
};


export type RootMutationTypeUpdateOrganizationArgs = {
  input: OrganizationChangeset;
};


export type RootMutationTypeUpdatePermissionArgs = {
  input: PermissionChangeset;
};


export type RootMutationTypeUpdateProfileArgs = {
  input: ProfileChangeset;
};


export type RootMutationTypeUpdateSettingsArgs = {
  input: SettingsChangeset;
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  /** Get an account by id */
  account?: Maybe<Account>;
  /** Get all accounts */
  accounts?: Maybe<Array<Maybe<Account>>>;
  /** Get an organization by id */
  organization?: Maybe<Organization>;
  /** Get all organizations */
  organizations?: Maybe<Array<Maybe<Organization>>>;
  /** Get an permission by id */
  permission?: Maybe<Permission>;
  /** Get all permissions */
  permissions?: Maybe<Array<Maybe<Permission>>>;
  /** Get current session */
  session?: Maybe<Session>;
};


export type RootQueryTypeAccountArgs = {
  input: Identity;
};


export type RootQueryTypeAccountsArgs = {
  input?: Maybe<ListParameters>;
};


export type RootQueryTypeOrganizationArgs = {
  input: Identity;
};


export type RootQueryTypeOrganizationsArgs = {
  input?: Maybe<ListParameters>;
};


export type RootQueryTypePermissionArgs = {
  input: Identity;
};


export type RootQueryTypePermissionsArgs = {
  input?: Maybe<ListParameters>;
};

export type RootSubscriptionType = {
  __typename?: 'RootSubscriptionType';
  /** When a new account is created */
  accountCreated?: Maybe<Account>;
  /** When a new organization is created */
  organizationCreated?: Maybe<Organization>;
  /** When a new permission is created */
  permissionCreated?: Maybe<Permission>;
  /** When a new session is created */
  sessionCreated?: Maybe<Session>;
};


export type RootSubscriptionTypeAccountCreatedArgs = {
  id: Scalars['ID'];
};


export type RootSubscriptionTypeOrganizationCreatedArgs = {
  id: Scalars['ID'];
};


export type RootSubscriptionTypePermissionCreatedArgs = {
  id: Scalars['ID'];
};


export type RootSubscriptionTypeSessionCreatedArgs = {
  id: Scalars['ID'];
};

export type Session = {
  __typename?: 'Session';
  account: Account;
  id?: Maybe<Scalars['String']>;
};

export type Settings = {
  __typename?: 'Settings';
  id: Scalars['ID'];
  lightMode: Scalars['Boolean'];
};

export type SettingsChangeset = {
  id: Scalars['ID'];
  lightMode?: Maybe<Scalars['Boolean']>;
};

export type FetchSessionQueryVariables = Exact<{ [key: string]: never; }>;


export type FetchSessionQuery = { __typename?: 'RootQueryType', session?: { __typename?: 'Session', id?: string | null | undefined } | null | undefined };

export type FetchAccountQueryVariables = Exact<{
  input: Identity;
}>;


export type FetchAccountQuery = { __typename?: 'RootQueryType', account?: { __typename?: 'Account', id: string, username?: string | null | undefined, emailAddress: string } | null | undefined };

export type UpdateAccountMutationVariables = Exact<{
  input: AccountChangeset;
}>;


export type UpdateAccountMutation = { __typename?: 'RootMutationType', updateAccount?: { __typename?: 'Account', id: string, emailAddress: string, username?: string | null | undefined } | null | undefined };

export type ConfirmAccountMutationVariables = Exact<{
  input: AccountConfirmation;
}>;


export type ConfirmAccountMutation = { __typename?: 'RootMutationType', confirmAccount?: { __typename?: 'Account', id: string } | null | undefined };

export type CreateSessionMutationVariables = Exact<{
  input: NewSession;
}>;


export type CreateSessionMutation = { __typename?: 'RootMutationType', createSession?: { __typename?: 'Session', id?: string | null | undefined } | null | undefined };

export type DestroySessionMutationVariables = Exact<{ [key: string]: never; }>;


export type DestroySessionMutation = { __typename?: 'RootMutationType', destroySession?: { __typename?: 'Session', id?: string | null | undefined } | null | undefined };

export type FetchMyAccountQueryVariables = Exact<{ [key: string]: never; }>;


export type FetchMyAccountQuery = { __typename?: 'RootQueryType', session?: { __typename?: 'Session', id?: string | null | undefined, account: { __typename?: 'Account', id: string, emailAddress: string } } | null | undefined };

export type UpdateMyAccountMutationVariables = Exact<{
  input: AccountChangeset;
}>;


export type UpdateMyAccountMutation = { __typename?: 'RootMutationType', updateAccount?: { __typename?: 'Account', id: string, emailAddress: string, username?: string | null | undefined } | null | undefined };

export type FetchYourProfileQueryVariables = Exact<{ [key: string]: never; }>;


export type FetchYourProfileQuery = { __typename?: 'RootQueryType', session?: { __typename?: 'Session', id?: string | null | undefined, account: { __typename?: 'Account', id: string, profile: { __typename?: 'Profile', id: string, publicName?: string | null | undefined } } } | null | undefined };

export type UpdateProfileMutationVariables = Exact<{
  input: ProfileChangeset;
}>;


export type UpdateProfileMutation = { __typename?: 'RootMutationType', updateProfile?: { __typename?: 'Profile', id: string, publicName?: string | null | undefined } | null | undefined };

export type FetchMySettingsQueryVariables = Exact<{ [key: string]: never; }>;


export type FetchMySettingsQuery = { __typename?: 'RootQueryType', session?: { __typename?: 'Session', id?: string | null | undefined, account: { __typename?: 'Account', id: string, settings: { __typename?: 'Settings', id: string, lightMode: boolean } } } | null | undefined };

export type UpdateSettingsMutationVariables = Exact<{
  input: SettingsChangeset;
}>;


export type UpdateSettingsMutation = { __typename?: 'RootMutationType', updateSettings?: { __typename?: 'Settings', id: string, lightMode: boolean } | null | undefined };

export type CreateAccountMutationVariables = Exact<{
  input: NewAccount;
}>;


export type CreateAccountMutation = { __typename?: 'RootMutationType', createAccount?: { __typename?: 'Account', id: string, emailAddress: string } | null | undefined };



export type ResolverTypeWrapper<T> = Promise<T> | T;


export type ResolverWithResolve<TResult, TParent, TContext, TArgs> = {
  resolve: ResolverFn<TResult, TParent, TContext, TArgs>;
};
export type Resolver<TResult, TParent = {}, TContext = {}, TArgs = {}> = ResolverFn<TResult, TParent, TContext, TArgs> | ResolverWithResolve<TResult, TParent, TContext, TArgs>;

export type ResolverFn<TResult, TParent, TContext, TArgs> = (
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => Promise<TResult> | TResult;

export type SubscriptionSubscribeFn<TResult, TParent, TContext, TArgs> = (
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => AsyncIterator<TResult> | Promise<AsyncIterator<TResult>>;

export type SubscriptionResolveFn<TResult, TParent, TContext, TArgs> = (
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => TResult | Promise<TResult>;

export interface SubscriptionSubscriberObject<TResult, TKey extends string, TParent, TContext, TArgs> {
  subscribe: SubscriptionSubscribeFn<{ [key in TKey]: TResult }, TParent, TContext, TArgs>;
  resolve?: SubscriptionResolveFn<TResult, { [key in TKey]: TResult }, TContext, TArgs>;
}

export interface SubscriptionResolverObject<TResult, TParent, TContext, TArgs> {
  subscribe: SubscriptionSubscribeFn<any, TParent, TContext, TArgs>;
  resolve: SubscriptionResolveFn<TResult, any, TContext, TArgs>;
}

export type SubscriptionObject<TResult, TKey extends string, TParent, TContext, TArgs> =
  | SubscriptionSubscriberObject<TResult, TKey, TParent, TContext, TArgs>
  | SubscriptionResolverObject<TResult, TParent, TContext, TArgs>;

export type SubscriptionResolver<TResult, TKey extends string, TParent = {}, TContext = {}, TArgs = {}> =
  | ((...args: any[]) => SubscriptionObject<TResult, TKey, TParent, TContext, TArgs>)
  | SubscriptionObject<TResult, TKey, TParent, TContext, TArgs>;

export type TypeResolveFn<TTypes, TParent = {}, TContext = {}> = (
  parent: TParent,
  context: TContext,
  info: GraphQLResolveInfo
) => Maybe<TTypes> | Promise<Maybe<TTypes>>;

export type IsTypeOfResolverFn<T = {}, TContext = {}> = (obj: T, context: TContext, info: GraphQLResolveInfo) => boolean | Promise<boolean>;

export type NextResolverFn<T> = () => Promise<T>;

export type DirectiveResolverFn<TResult = {}, TParent = {}, TContext = {}, TArgs = {}> = (
  next: NextResolverFn<TResult>,
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => TResult | Promise<TResult>;

/** Mapping between all available schema types and the resolvers types */
export type ResolversTypes = {
  Account: ResolverTypeWrapper<Account>;
  AccountChangeset: AccountChangeset;
  AccountConfirmation: AccountConfirmation;
  Boolean: ResolverTypeWrapper<Scalars['Boolean']>;
  ID: ResolverTypeWrapper<Scalars['ID']>;
  Identity: Identity;
  Int: ResolverTypeWrapper<Scalars['Int']>;
  ListParameters: ListParameters;
  NaiveDateTime: ResolverTypeWrapper<Scalars['NaiveDateTime']>;
  NewAccount: NewAccount;
  NewOrganization: NewOrganization;
  NewPermission: NewPermission;
  NewSession: NewSession;
  Organization: ResolverTypeWrapper<Organization>;
  OrganizationChangeset: OrganizationChangeset;
  OrganizationMembership: ResolverTypeWrapper<OrganizationMembership>;
  OrganizationPermission: ResolverTypeWrapper<OrganizationPermission>;
  Permission: ResolverTypeWrapper<Permission>;
  PermissionChangeset: PermissionChangeset;
  Profile: ResolverTypeWrapper<Profile>;
  ProfileChangeset: ProfileChangeset;
  RootMutationType: ResolverTypeWrapper<{}>;
  RootQueryType: ResolverTypeWrapper<{}>;
  RootSubscriptionType: ResolverTypeWrapper<{}>;
  Session: ResolverTypeWrapper<Session>;
  Settings: ResolverTypeWrapper<Settings>;
  SettingsChangeset: SettingsChangeset;
  String: ResolverTypeWrapper<Scalars['String']>;
};

/** Mapping between all available schema types and the resolvers parents */
export type ResolversParentTypes = {
  Account: Account;
  AccountChangeset: AccountChangeset;
  AccountConfirmation: AccountConfirmation;
  Boolean: Scalars['Boolean'];
  ID: Scalars['ID'];
  Identity: Identity;
  Int: Scalars['Int'];
  ListParameters: ListParameters;
  NaiveDateTime: Scalars['NaiveDateTime'];
  NewAccount: NewAccount;
  NewOrganization: NewOrganization;
  NewPermission: NewPermission;
  NewSession: NewSession;
  Organization: Organization;
  OrganizationChangeset: OrganizationChangeset;
  OrganizationMembership: OrganizationMembership;
  OrganizationPermission: OrganizationPermission;
  Permission: Permission;
  PermissionChangeset: PermissionChangeset;
  Profile: Profile;
  ProfileChangeset: ProfileChangeset;
  RootMutationType: {};
  RootQueryType: {};
  RootSubscriptionType: {};
  Session: Session;
  Settings: Settings;
  SettingsChangeset: SettingsChangeset;
  String: Scalars['String'];
};

export type AccountResolvers<ContextType = any, ParentType extends ResolversParentTypes['Account'] = ResolversParentTypes['Account']> = {
  emailAddress?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  organizationMemberships?: Resolver<Maybe<Array<ResolversTypes['OrganizationMembership']>>, ParentType, ContextType>;
  organizations?: Resolver<Maybe<Array<Maybe<ResolversTypes['Organization']>>>, ParentType, ContextType>;
  profile?: Resolver<ResolversTypes['Profile'], ParentType, ContextType>;
  settings?: Resolver<ResolversTypes['Settings'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  username?: Resolver<Maybe<ResolversTypes['String']>, ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export interface NaiveDateTimeScalarConfig extends GraphQLScalarTypeConfig<ResolversTypes['NaiveDateTime'], any> {
  name: 'NaiveDateTime';
}

export type OrganizationResolvers<ContextType = any, ParentType extends ResolversParentTypes['Organization'] = ResolversParentTypes['Organization']> = {
  accounts?: Resolver<Maybe<Array<ResolversTypes['Account']>>, ParentType, ContextType>;
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  name?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  organizationPermissions?: Resolver<Maybe<Array<ResolversTypes['OrganizationPermission']>>, ParentType, ContextType>;
  permissions?: Resolver<Maybe<Array<ResolversTypes['Permission']>>, ParentType, ContextType>;
  slug?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type OrganizationMembershipResolvers<ContextType = any, ParentType extends ResolversParentTypes['OrganizationMembership'] = ResolversParentTypes['OrganizationMembership']> = {
  account?: Resolver<ResolversTypes['Account'], ParentType, ContextType>;
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  organization?: Resolver<ResolversTypes['Organization'], ParentType, ContextType>;
  organizationPermissions?: Resolver<Maybe<Array<ResolversTypes['OrganizationPermission']>>, ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type OrganizationPermissionResolvers<ContextType = any, ParentType extends ResolversParentTypes['OrganizationPermission'] = ResolversParentTypes['OrganizationPermission']> = {
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  organization?: Resolver<ResolversTypes['Organization'], ParentType, ContextType>;
  permission?: Resolver<ResolversTypes['Permission'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type PermissionResolvers<ContextType = any, ParentType extends ResolversParentTypes['Permission'] = ResolversParentTypes['Permission']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  name?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  organizationPermissions?: Resolver<Maybe<Array<ResolversTypes['OrganizationPermission']>>, ParentType, ContextType>;
  slug?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type ProfileResolvers<ContextType = any, ParentType extends ResolversParentTypes['Profile'] = ResolversParentTypes['Profile']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  publicName?: Resolver<Maybe<ResolversTypes['String']>, ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type RootMutationTypeResolvers<ContextType = any, ParentType extends ResolversParentTypes['RootMutationType'] = ResolversParentTypes['RootMutationType']> = {
  confirmAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeConfirmAccountArgs, 'input'>>;
  createAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeCreateAccountArgs, 'input'>>;
  createOrganization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootMutationTypeCreateOrganizationArgs, 'input'>>;
  createPermission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootMutationTypeCreatePermissionArgs, 'input'>>;
  createSession?: Resolver<Maybe<ResolversTypes['Session']>, ParentType, ContextType, RequireFields<RootMutationTypeCreateSessionArgs, 'input'>>;
  destroyAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeDestroyAccountArgs, 'input'>>;
  destroyOrganization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootMutationTypeDestroyOrganizationArgs, 'input'>>;
  destroyPermission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootMutationTypeDestroyPermissionArgs, 'input'>>;
  destroySession?: Resolver<Maybe<ResolversTypes['Session']>, ParentType, ContextType>;
  updateAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateAccountArgs, 'input'>>;
  updateOrganization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateOrganizationArgs, 'input'>>;
  updatePermission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdatePermissionArgs, 'input'>>;
  updateProfile?: Resolver<Maybe<ResolversTypes['Profile']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateProfileArgs, 'input'>>;
  updateSettings?: Resolver<Maybe<ResolversTypes['Settings']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateSettingsArgs, 'input'>>;
};

export type RootQueryTypeResolvers<ContextType = any, ParentType extends ResolversParentTypes['RootQueryType'] = ResolversParentTypes['RootQueryType']> = {
  account?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootQueryTypeAccountArgs, 'input'>>;
  accounts?: Resolver<Maybe<Array<Maybe<ResolversTypes['Account']>>>, ParentType, ContextType, RequireFields<RootQueryTypeAccountsArgs, never>>;
  organization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootQueryTypeOrganizationArgs, 'input'>>;
  organizations?: Resolver<Maybe<Array<Maybe<ResolversTypes['Organization']>>>, ParentType, ContextType, RequireFields<RootQueryTypeOrganizationsArgs, never>>;
  permission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootQueryTypePermissionArgs, 'input'>>;
  permissions?: Resolver<Maybe<Array<Maybe<ResolversTypes['Permission']>>>, ParentType, ContextType, RequireFields<RootQueryTypePermissionsArgs, never>>;
  session?: Resolver<Maybe<ResolversTypes['Session']>, ParentType, ContextType>;
};

export type RootSubscriptionTypeResolvers<ContextType = any, ParentType extends ResolversParentTypes['RootSubscriptionType'] = ResolversParentTypes['RootSubscriptionType']> = {
  accountCreated?: SubscriptionResolver<Maybe<ResolversTypes['Account']>, "accountCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypeAccountCreatedArgs, 'id'>>;
  organizationCreated?: SubscriptionResolver<Maybe<ResolversTypes['Organization']>, "organizationCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypeOrganizationCreatedArgs, 'id'>>;
  permissionCreated?: SubscriptionResolver<Maybe<ResolversTypes['Permission']>, "permissionCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypePermissionCreatedArgs, 'id'>>;
  sessionCreated?: SubscriptionResolver<Maybe<ResolversTypes['Session']>, "sessionCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypeSessionCreatedArgs, 'id'>>;
};

export type SessionResolvers<ContextType = any, ParentType extends ResolversParentTypes['Session'] = ResolversParentTypes['Session']> = {
  account?: Resolver<ResolversTypes['Account'], ParentType, ContextType>;
  id?: Resolver<Maybe<ResolversTypes['String']>, ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type SettingsResolvers<ContextType = any, ParentType extends ResolversParentTypes['Settings'] = ResolversParentTypes['Settings']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  lightMode?: Resolver<ResolversTypes['Boolean'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type Resolvers<ContextType = any> = {
  Account?: AccountResolvers<ContextType>;
  NaiveDateTime?: GraphQLScalarType;
  Organization?: OrganizationResolvers<ContextType>;
  OrganizationMembership?: OrganizationMembershipResolvers<ContextType>;
  OrganizationPermission?: OrganizationPermissionResolvers<ContextType>;
  Permission?: PermissionResolvers<ContextType>;
  Profile?: ProfileResolvers<ContextType>;
  RootMutationType?: RootMutationTypeResolvers<ContextType>;
  RootQueryType?: RootQueryTypeResolvers<ContextType>;
  RootSubscriptionType?: RootSubscriptionTypeResolvers<ContextType>;
  Session?: SessionResolvers<ContextType>;
  Settings?: SettingsResolvers<ContextType>;
};


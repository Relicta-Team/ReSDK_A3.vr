// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// This is abstraction to make it easier to run multiple implementation with different data layouts

#include "loader.hpp"
#include "controller.hpp"

using namespace intercept;

#define CMDSC_TYPE Base
#define CT_VERSION 0

namespace __CTBase {
#include "CommandTypes.hpp"
}

#include "CommandTypes.hpp"
#include "CommandScan.hpp"

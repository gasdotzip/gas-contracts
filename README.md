<p align="center">
 <img width="100px" src="https://www.gas.zip/gasLogo400x400.png" align="center" />
 <h3 align="center">Gas.zip Gas Reloader</h3>
 <p align="center">Instant bulk gas reloader supporting over 300+ chains.</p>
</p>

### Overview

The Gas.zip gas refuel bridge supports over 300+ destination chains and 25 source chains. The primary function from a user's perspective is depositing, where you send native assets to a Gas.zip EOA address along with specific calldata to distribute funds among your desired destination chains. All software is licensed under MIT and is verified on-chain at the [respective addresses](https://dev.gas.zip/gas/chain-support/inbound). 

### Depositing to Gas.zip (v2)

Each inbound source chain has a designated EOA address that can accept the chain's native gas asset (e.g. ETH, AVAX, BNB, MATIC) between $0.25 USD and $50.00 USD. Gas uses the CoinGecko API for real-time coin price calculations.

**WARNING:** Do not send less than $0.25 USD or more than $50.00 USD **PER CHAIN** to the deposit() function. Please contact us in [Discord](https://discord.gg/gasdotzip) via a support ticket if you have accidentally done so.

To make a deposit, you must include calldata specifying the destination chains and target recipient address. The destination address can be different from the sending address. The destination chain IDs are not the native chain IDs of each blockchain, but internal IDs designated by Gas.zip. Please see [Chain Support](https://dev.gas.zip/gas/chain-support/outbound) for this list of chain IDs.

For detailed instructions on how to integrate Gas.zip into your project, including code examples and best practices, please refer to our [v2 Intergration Guide](https://dev.gas.zip/gas/code-examples/evm-deposit/eoaDeposit) for EOA deposits, for integrators looking to deposit with a low-level call, please use the [v1 Contract Deposit](https://dev.gas.zip/gas/code-examples/evm-deposit/contractDeposit).

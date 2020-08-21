import data.real.basic
import analysis.special_functions.exp_log
import .quantum_state
import ..optical_fiber.quantum_channel

notation `|` x `|` := abs x

variables (n m : ℕ)

---- QUANTUM ENTROPY

/-
Definition (Quantum entropy): 
-/
def quantum_entropy (ρ : density_operator n) : ℝ := - Tr(ρ.M * matrix_log(ρ.M))

notation `H(` ρ `)` := quantum_entropy(ρ)

/-
Theorem (non-negativity): Quantum entropy is non-negative.
-/
theorem quantum_entropy_nonnegative : ∀ (ρ : density_operator n), H(ρ) ≥ 0 :=
-- proof
begin
    sorry
end

/-
Theorem (minimum value): The minimum value of quantum entropy is 
zero and occurs when the state is pure.
-/
theorem minimum_value_quantum_entropy : 
∀ (ρ : density_operator n), is_pure ρ → H(ρ) = 0 := sorry

/-
Theorem (maximum value): The maximum value of quantum entropy is 
log d and occurs when the state is the maximally mixed state.
-/
theorem maximum_value_quantum_entropy {ρ : density_operator} : 
H(ρ) ≤ real.log ρ.dim :=
begin
    sorry
end

/-
Theorem (additivity for tensor states)
-/
theorem additive_quantum_entropy_tensor_states :
∀ (ρ₁ : density_operator n) (ρ₂ : density_operator m), H(ρ₁ ⊗ ρ₂) = H(ρ₁) + H(ρ₂) := 
begin
    sorry
end

/-
Theorem (Araki-Lieb triangle inequality)
-/
theorem Araki_Lieb {ρ : density_operator} : 
|H(A)_ρ - H(B)_ρ| ≤ H(AB)_ρ := 
begin
    sorry
end

/-
Theorem (strong subadditivity)
Page 345 here https://arxiv.org/pdf/1106.1445.pdf.
-/
theorem strong_subadditivity {ρ : density_operator} :
H(AC)_ρ + H(BC)_ρ ≥ H(ABC)_ρ + H(C)_ρ :=
begin
    have : I(A;B|C)_ρ = H(AC)_ρ + H(BC)_ρ - H(ABC)_ρ - H(C)_ρ, {sorry},
    have : I(A;B|C)_ρ = H(B|C)_ρ - H(B|AC)_ρ, {sorry},
    have : -H(B|AC)_ρ = D(ρ∥I⊗Tr_B(ρ)), {sorry},
    have : H(B|C)_ρ =  -D(Tr_A(ρ)∥I⊗Tr_AB(ρ)), {sorry},
    have : D(ρ∥I_B⊗Tr_B(ρ)) ≥ D(Tr_A(ρ)∥I_B⊗Tr_AB(ρ)), {sorry},
    sorry
end

/-
Theorem (unital channels increase entropy)
-/
theorem unital_channels_increase_entropy 
{ρ : density_operator} {𝒩 : quantum_channel} {h𝒩 : is_unital(𝒩)} : 
H(𝒩(ρ)) ≥ H(ρ) :=
begin
    sorry
end




---- CONDITIONAL QUANTUM ENTROPY

/-
Definition (conditional quantum entropy)
-/
def cond_quantum_entropy (ρ : density_operator n) : ℝ := H(ρ) - H(Tr_A(ρ))

notation `H(` A `|` B `)_` ρ := cond_quantum_entropy(ρ)

/-
Theorem (conditioning does not increase entropy)
-/
theorem cond_entropy_leq_entropy (ρ : density_operator n) : 
H(A)_ρ ≥ H(A|B)_ρ := 
begin
    sorry
end

/-
Theorem (maximum of abs of conditional quantum entropy)
Page 333 here https://arxiv.org/pdf/1106.1445.pdf.
-/
theorem cond_quantum_entropy_max : 
∀ (ρ : density_operator), |H(A|B)_ρ| ≤ real.log Tr_B(ρ).dim :=
begin
    -- start by rewriting using abs_le

    -- first we prove that H(A|B)_ρ ≤ real.log Tr_B(ρ).dim

    -- then we prove that H(A|B)_ρ ≥ - real.log Tr_B(ρ).dim
    sorry
end

/-
Theorem (The π_A ⊗ π_B state saturates condition quantum entropy)
-/
theorem cond_quantum_entropy_saturated {ρ := π⊗π} : 
H(A|B)_ρ = real.log Tr_B(ρ).dim := 
begin
    sorry
end




---- COHERENT INFORMATION

/-
Definition (coherent information)
-/
def coherent_information (ρ : density_operator) {hρ : ρ.dim ≥ 4} : ℝ := 
H(pTr(ρ.M , ρ.dim/2)) - H(ρ)

notation `I(` A `⟩` B `)_` ρ := coherent_information(ρ)

/-
Definition (reverse coherent information): 
-/
def reverse_coherent_information (ρ : density_operator) := sorry

/-
Theorem (coherent information of a maximally entangled state)
-/
theorem coherent_info_max_ent_state 
{ρ : density_operator} {hρ : is_maximally_entangled} :
I(A⟩B)_ρ = ... := 
begin
    sorry
end

/-
Theorem (coherent information of purification)
"Thus, there is a sense in which the coherent information 
measures the difference in the uncertainty of Bob and the 
uncertainty of the environment."
https://arxiv.org/pdf/1106.1445.pdf
-/
theorem coh_info_purification : 
∀ (ρ : density_operator), 
    ∃ {∣ψ⟩ : pure_state} {hψ : is_purification ρ ∣ψ⟩}, 
        I(A⟩B)_ρ = H(B)_∣ψ⟩ - H(E)_∣ψ⟩ :=
begin
    sorry
end




---- QUANTUM MUTUAL INFORMATION

/-
Definition (quantum mutual information)
-/
def mut_info (ρ : density_operator) : ℝ := 
H(A)_ρ + H(B)_ρ - H(AB)_ρ

notation `I(` A `;` B `)_` ρ := mut_info(ρ)

/-
Lemma (rewrite in terms of cond entropy)
-/
lemma mut_info_cond_ent {ρ : density_operator} :
I(A;B)_ρ = H(A)_ρ - H(A|B)_ρ :=
begin
    sorry
end

/-
Lemma (another rewrite in terms of cond entropy)
-/
lemma mut_info_cond_ent' {ρ : density_operator} : 
I(A;B)_ρ = H(B)_ρ - H(B|A)_ρ :=
begin
    sorry
end

/-
Lemma (non-negativity)
-/
lemma mut_info_nonnegative {ρ : density_operator} : 
I(A;B)_ρ ≥ 0 :=
begin
    sorry
end




---- HOLEVO INFORMATION

/-
Definition (Holevo information)
-/
def Holevo_information (ρ : density_operator) := sorry




---- ACCESSIBLE INFORMATION

/-
Definition (accessible information)
-/
def accessible_info := sorry




---- CONDITIONAL QUANTUM MUTUAL INFORMATION

/-
Definition (conditional quantum mutual information)
-/
def cond_mut_info (ρ : density_operator) : ℝ := 
H(A|C)_ρ + H(B|C)_ρ - H(AB|C)_ρ

notation `I(` A `;` B `|` C `)_` ρ := cond_mut_info ρ

/-
Lemma (quanutm mutual information chain rule)
-/
lemma mut_info_chain_rule {ρ : density_operator} :
I(A;BC)_ρ = I(A;B)_ρ + I(A;C|B)_ρ :=
begin
    sorry
end

/-
Lemma (non-negativity / a.k.a. strong subadditivity)
-/
lemma cond_mut_info_nonnegative {ρ : density_operator} : 
I(A;B|C)_ρ ≥ 0 :=
begin
    sorry
end

/-
Lemma ("duality" of condition mutual information)
-/
lemma duality {ρ : density_operator} {hρ : is_pure ρ} : 
I(A;B|C)_ρ = I(A;B|D)_ρ :=
begin
    sorry
end




---- QUANTUM RELATIVE ENTROPY

/-
Definition (quantum relative entropy)
-/
def quantum_relative_entropy (ρ : density_operator) (σ : positive_semidefinite_operator) := sorry

notation `D(` ρ `∥` σ `)` := quantum_relative_entropy(ρ,σ)

/-
Theorem (quantum Pinsker inequality)
-/
theorem quantum_pinsker {ρ : density_operator} {σ : linear_operator} : 
D(ρ∥σ) ≥ 1/(2 * ln 2) * ∥ρ - σ∥₁^2 := 
begin
    sorry
end




---- SQUASHED ENTANGLEMENT

/-
Definition (squashed entanglement of quantum state for a given partition)
-/
def squashed_entanglement (ρ : density_operator) 
{hρ : ρ.dim > 4} (partition_point : ℕ) : ℝ := sorry
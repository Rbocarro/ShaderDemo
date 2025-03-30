using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class ShaderManager : MonoBehaviour
{
    [Header("Dropdown UI")]
    public TMP_Dropdown dropdown; // Use TextMeshPro Dropdown
    public TextMeshProUGUI materialNameText;
    public TextMeshProUGUI materialDescriptionText;

    [Header("3D Object")]
    public MeshRenderer targetRenderer; // The 3D object to apply the material

    [Header("Shader Material Options")]
    public List<ShaderMaterialData> shaderMaterials; // List of ScriptableObjects

    private void Awake()
    {
        PopulateDropdown();
        dropdown.onValueChanged.AddListener(delegate { ChangeMaterial(dropdown.value); });
    }

    // Populate dropdown with shader material names
    void PopulateDropdown()
    {
        List<string> options = new List<string>();

        foreach (var shaderData in shaderMaterials)
        {
            options.Add(shaderData.name);
        }

        dropdown.ClearOptions();
        dropdown.AddOptions(options);
        ChangeMaterial(0); // Default to first option
    }

    // Change the material based on selected option
    public void ChangeMaterial(int index)
    {
        if (shaderMaterials == null || shaderMaterials.Count == 0 || index >= shaderMaterials.Count)
        {
            Debug.LogWarning("Invalid material selection.");
            return;
        }

        ShaderMaterialData selectedMaterial = shaderMaterials[index];

        if (targetRenderer != null && selectedMaterial.material != null)
        {
            targetRenderer.material = selectedMaterial.material;
            materialNameText.text = selectedMaterial.materialName;
            materialDescriptionText.text = selectedMaterial.materialDescription;
        }
    }
}
